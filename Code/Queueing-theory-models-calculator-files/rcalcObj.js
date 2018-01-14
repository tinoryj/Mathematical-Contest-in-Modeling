/* 
 * Supositorio.com all rights reserved
 * Personal non-commercial Use Only
 * cannot compete to any properties 
 * related to Supositorio.com
 * 
 */


// Convert units
var ConvertUnits = {
    hoursPerDay: 24,
    secondsPerHour: 3600, // 60 min * 60 sec
    minutesPerHour: 60, // 60 min
    daysPerHour: 1 / 24,
    setHoursPerDay: function(hours){
        this.hoursPerDay = hours;
        this.daysPerHour = 1 / this.hoursPerDay;
    },
    perHour: new Array(),
    construct : function(hours){
        this.setHoursPerDay((hours === undefined)? 24 : hours);
        this.perHour[0] = 1 / this.hoursPerDay;
        this.perHour[1] = 1;
        this.perHour[2] = this.minutesPerHour;
        this.perHour[3] = this.secondsPerHour;
    },
    /*
     * @param {float} value
     * @param {int} unitsFrom id (0-> entities/day, 1-> entities/hour, 2-> entities/minute, 3-> entities/second
     * @param {int} unitsTo id (0-> entities/day, 0-> entities/hour, 0-> entities/minute, 0-> entities/second
     * @returns {float}
     */
    fromTo : function(value, from, to){
        if((from === -1 && to === -1) || (from === to)){
            return value;
        }else{
            return value * this.perHour[from] / this.perHour[to];
        }
        
    }
};
ConvertUnits.construct();

var Stats = {
    combination: function(high, low){
        return (this.factorial(high) / (this.factorial(low) * this.factorial(high - low)));
    },
    power: function(base, exponent){
        return Math.pow(base, exponent);
    },
    root: function(number, nRoot){
        return Math.pow(number, 1 / nRoot);
    },
    absolute: function(number){
        return Math.abs(number);
    },
    factorial: function(n){
        var f = [];
        if (n === 0 || n === 1){
            return 1;
        }else{
            f[1] = 1;
            for(var i=2; i<=n; i++){
                f[i] = f[i-1] * i;
            }
        }
    return f[n]; 
    },
    round: function(floatValue, decimals){
        return (Math.round(floatValue * Math.pow(10, decimals)) / Math.pow(10, decimals));
    }
};

var Queuing = {
    model: undefined,
    n: 0,
    Lambda: undefined,
    Mu: undefined,
    c: undefined,
    k: undefined,
    m: undefined,
    T: 0,
    Tq: 0,
    r: 0,
    cp: 0,
    Ro: 0,
    Po: 0,
    hoursPerDay: 0,
    LambdaUnits: -1, // -1 -> no units, 0 -> Days, 1 -> Hours, 2 -> Minutes, 3 -> Seconds
    MuUnits: -1,
    ResultsUnits: 2,
    constructor: function(model, C, K, M, Lambda, Mu, n, T, Tq, hoursPerDay){
        this.model = model;
        this.c = C;
        this.k = K;
        this.m = M;
        this.Lambda = Lambda;
        this.Mu = Mu;
        this.n = n;
        this.T = T;
        this.Tq = Tq;
        this.hoursPerDay = hoursPerDay;
    },
    MMC: function(){
        this.r = this.Lambda / this.Mu;
        this.cp = this.c + 1;
        this.Ro = this.Lambda / (this.c * this.Mu);
        
        for (i = 0, this.Po = 0; i <= this.c - 1; i++) {
            this.Po += Stats.power(this.r, i) / Stats.factorial(i);
        }
        this.Po += (this.c * Stats.power(this.r, this.c)) / (Stats.factorial(this.c) * (this.c - this.r));
        this.Po = Stats.power(this.Po, -1);
        
        this.cx = 1 - this.r / this.c;
        this.Lq = Stats.power(this.r, this.cp) * this.Po / (Stats.factorial(this.c) * this.c * Stats.power(this.cx, 2));
        
        this.Wq = this.Lq / this.Lambda;
        
        this.L = this.r + (this.Po * Stats.power(this.r, this.cp)) / (this.c * Stats.factorial(this.c) * Stats.power(this.cx, 2));
        
        this.W = this.L / this.Lambda;
        
        
    },
    /*
     * The MMC model has to be calculated first
     * this.n must be set before calculating
     * MMC_Prob
     */
    MMC_Prob: function(){
        if (!this.n) {
            this.Pn = this.Po;
        } else if (this.n >= 1 && this.n <= this.c) {
            this.Pn = (Stats.power(this.r, this.n) * this.Po) / Stats.factorial(this.n);
        } else if (this.n > this.c) {
            this.Pn = (this.Po * Stats.power(this.Ro, this.n) * Stats.power(this.c, this.c)) / Stats.factorial(this.c);
        } else this.Pn = null;
    },
    /*
     * The MMC model has to be calculated first
     * this.t and this.tq must be set before calculating
     * MMC_Prob
     */
    MMC_ProbTime: function(){
        this.Pjs = Stats.power(this.r, this.c) * this.Po / (Stats.factorial(this.c) * (1 - this.Ro));
        if ((this.c - 1) === this.c * this.Ro) {
            this.T = 1 - Math.exp(-this.Mu * this.t) * (1 + this.Pjs * this.Mu * this.t);
        } else {
            this.T = 1 - (Math.exp(-this.Mu * this.t) * (1 + this.Pjs * (1 - Math.exp(-this.Mu * this.t * (this.c - 1 - this.c * this.Ro))) / (this.c - 1 - this.c * this.Ro)));
        }
        this.Tq = 1 - (this.Pjs * Math.exp(-this.c * this.Mu * (1 - this.Ro) * this.tq));
    },
    MMInf: function(){
        this.r = this.Lambda / this.Mu;
        this.W = 1 / this.Mu;
        this.L = this.r;
    },
    MMInf_Prob: function(){
        this.Pn = Stats.power(this.r, this.n) * Math.exp(-this.r) / Stats.factorial(this.n);
    },
    MMCK: function(){
        
        var i = 0;
        this.Ro = this.Lambda / (this.c * this.Mu);
        this.r = this.Lambda / this.Mu;
        if (this.Ro !== 1) {
            for (i = 0, this.Po = 0; i <= this.c - 1; i++) {
                this.Po += Stats.power(this.r, i) / Stats.factorial(i);
            }
            this.Po += Stats.power(this.r, this.c) * (1 - Stats.power(this.Ro, this.k - this.c + 1)) / (Stats.factorial(this.c) * (1 - this.Ro));
            this.Po = Stats.power(this.Po, -1);
        } else {
            for (i = 0; i <= this.c - 1; i++) {
                this.Po += Stats.power(this.r, i) / Stats.factorial(i);
            }
            this.Po += Stats.power(this.r, this.c) * (this.k - this.c + 1) / (Stats.factorial(this.c));
            this.Po = Stats.power(this.Po, -1);
        } if (this.Ro !== 1) {
            this.Lq = this.Po * Stats.power(this.c * this.Ro, this.c) * this.Ro * (1 - Stats.power(this.Ro, this.k - this.c + 1) - (1 - this.Ro) * (this.k - this.c + 1) * Stats.power(this.Ro, this.k - this.c)) / (Stats.factorial(this.c) * Stats.power(1 - this.Ro, 2));
        } else {
            this.Lq = this.Po * Stats.power(this.c, this.c) * (this.k - this.c) * (this.k - this.c + 1) / (2 * Stats.factorial(this.c));
        }
        for (i = 0; i <= this.c - 1; i++) {
            this.L = (this.c - i) * Stats.power(this.Ro * this.c, i) / Stats.factorial(i);
        }
        this.L *= -this.Po;
        this.L += this.Lq + this.c;
        
        if (this.k === 0) {
            this.Pk = this.Po;
        } else if (1 <= this.k && this.k <= this.c) {
            this.Pk = Stats.power(this.r, this.k) * this.Po / Stats.factorial(this.k);
        } else {
            this.Pk = Stats.power(this.r, this.k) * this.Po / (Stats.factorial(this.c) * Stats.power(this.c, this.k - this.c));
        }
        this.Lambdap = this.Lambda * (1 - this.Pk);
        this.W = this.L / this.Lambdap;
        this.Wq = this.W - 1 / this.Mu;
    },
    MMCK_Prob:function(){
        if (this.n === 0) {
            this.Pn = this.Po;
        } else if (1 <= this.n && this.n <= this.c) {
            this.Pn = Stats.power(this.r, this.n) * this.Po / Stats.power(this.n, this.k - this.c);
        } else {
            this.Pn = Stats.power(this.r, this.n) * this.Po / (Stats.factorial(this.c) * Stats.power(this.c, this.n - this.c));
        }
    },
    MMC_M:function(){
        
        this.r = this.Lambda / this.Mu;
        for (i = 0, this.Po_1 = 0; i < this.c; i++) {
            this.Po_1 += Stats.combination(this.m, i) * Stats.power(this.r, i);
        }
        for (i = this.c, this.Px = 0; i <= this.m; i++) {
            this.Px += Stats.combination(this.m, i) * Stats.factorial(i) * Stats.power(this.r, i) / (Stats.power(this.c, i - this.c) * Stats.factorial(this.c));
        }
        this.Po = 1 / (this.Po_1 + this.Px);
        
        this.L = 0;
        for (i = 0; i <= this.c - 1; i++) {
            this.L += i * Stats.combination(this.m, i) * Stats.power(this.r, i);
        }
        for (i = this.c; i <= this.m; i++) {
            this.L += i * Stats.combination(this.m, i) * Stats.power(this.r, i) * Stats.factorial(i) / (Stats.power(this.c, i - this.c) * Stats.factorial(this.c));
        }
        this.L *= this.Po;
        this.Lq = 0;
        for (i = 0; i <= this.c - 1; i++) {
            this.Lq += (this.c - i) * Stats.combination(this.m, i) * Stats.power(this.r, i);
        }
        this.Lq *= this.Po;
        this.Lq = this.Lq + this.L - this.c;
        this.W = this.L / (this.Lambda * (this.m - this.L));
        this.Wq = this.Lq / (this.Lambda * (this.m - this.L));
        this.Lambdap = this.Mu * (this.L - this.Lq);
    },
    MMC_M_Prob:function(){
        if (0 <= this.n && this.n < this.c) {
            this.Pn = Stats.combination(this.m, this.n) * Stats.power(this.r, this.n) * this.Po;
        } else if (this.n >= this.c && this.n <= this.m) {
            this.Pn = Stats.combination(this.m, this.n) * Stats.factorial(this.n) * Stats.power(this.r, this.n) * this.Po / (Stats.power(this.c, this.n - this.c) * Stats.factorial(this.c));
        } else {
            this.Pn = 0;
        }
    },
    calculate:function(){
        this.n = 0;
        // Convert Lambda Value to Results Units
        if(this.ResultsUnits === -1 && !(this.LambdaUnits === -1 && this.MuUnits === -1)){
            // Avoid calculating something without units
            QError.setResultsUnits();
        }
        this.Lambda = ConvertUnits.fromTo(this.Lambda, this.LambdaUnits, this.ResultsUnits);
        // Convert Mu Value to Results Units
        this.Mu = ConvertUnits.fromTo(this.Mu, this.MuUnits, this.ResultsUnits);
        
        switch(this.model){
            case 1: 
                this.MMC();
                break;
            case 2: 
                this.MMInf();
                break;
            case 3: 
                this.MMCK();
                break;
            case 4: 
                this.MMC_M();
                break;
        }
    },
    calculateProb:function(){
        switch(this.model){
            case 1: 
                this.MMC_Prob();
                break;
            case 2: 
                this.MMInf_Prob();
                break;
            case 3: 
                this.MMCK_Prob();
                break;
            case 4: 
                this.MMC_M_Prob();
                break;
        }
    },
    calculateProbTime:function(){
        switch(this.model){
            case 1: 
                this.MMC_ProbTime();
                break;
            case 2: 
                this.MMC_ProbTime();
                break;
            case 3: 
                this.MMC_ProbTime();
                break;
            case 4: 
                this.MMC_ProbTime();
                break;
        }
    }
};
var QError = {
    messages: new Object(),
    valuesArr: new Object(),
    unset: function(){
        this.messages = new Array();
        this.valuesArr = new Array();
    },
    setRo: function(c){
        this.valuesArr.Ro = 1;
        this.messages.RoMessage = unescape('The queues will tend to infinity as Lambda is greater or equal than ' + c + ' times Mu');
    },
    setModel: function(){
        this.valuesArr.Model = 1;
        this.messages.Model = unescape('You did not select any queuing model');
    },
    setC: function(){
        this.valuesArr.c = 1;
        this.messages.c = unescape('You did not enter any value for C (no. of servers)');
    },
    setK: function(){
        this.valuesArr.k = 1;
        this.messages.k = unescape('You did not enter any value for K (queue capacity)');
    },
    setM: function(){
        this.valuesArr.m = 1;
        this.messages.m = unescape('You did not enter any value for M (Entities population)');
    },
    setMu: function(){
        this.valuesArr.Mu = 1;
        this.messages.Mu = unescape('You did not enter any value for Mu');
    },
    setLambda: function(){
        this.valuesArr.Lambda = 1;
        this.messages.Lambda = unescape('You did not enter any value for Lambda');
    },
    setPopulation: function(){
        this.valuesArr.population = 1;
        this.messages.population = unescape('There cannot be more entities in the system than the total population, please verify your input');
    },
    setIncompatibility: function(){
        this.valuesArr.incompatibility = 1;
        this.messages.incompatibility = unescape('There cannot be more entities in the system than the total population, please verify your input');
    },
    setUnits: function(){
        this.valuesArr.units = 1;
        this.messages.units = unescape('The units of Mu and Lambda are incompatible');
    },
    setResultsUnits: function(){
        this.valuesArr.resultsUnits = 1;
        this.messages.resultsUnits = unescape('The units of the results are not set please set them first');
    },
    lookForCalculationErrors: function(){
        this.unset();
        // Check there is no error in rho
        switch(Queuing.model){
            case 1: 
                if(Queuing.Lambda >= Queuing.Mu * Queuing.c){
                    this.setRo(Queuing.c);
                }
                break;
            case 2:
                break;
            case 3: 
                if(Queuing.Lambda > Queuing.Mu * Queuing.c){
                    this.setRo(Queuing.c);
                }
                break;
            case 4: 
                if(Queuing.Lambda > Queuing.Mu * Queuing.c){
                    this.setRo(Queuing.c);
                }
                break;
            default:
                break;
        }
        if(isNaN(Queuing.model)){
            this.setModel();
        }
        if(isNaN(Queuing.c) && Queuing.model !== 2){
            this.setC();
        }
        if(isNaN(Queuing.k) && Queuing.model === 3){
            this.setK();
        }
        if(isNaN(Queuing.m) && Queuing.model === 4){
            this.setM();
        }
        if(isNaN(Queuing.Lambda)){
            this.setLambda();
        }
        if(isNaN(Queuing.Mu)){
            this.setMu();
        }
        if(Queuing.n > Queuing.m){
            this.setPopulation();
        }
        
    },
    lookForUnitsErrors: function(){
        if((Queuing.MuUnits === -1 || Queuing.LambdaUnits === -1) && Queuing.MuUnits === Queuing.LambdaUnits){
            this.setIncompatibility();
        }
    }
};

var setter = {
    c:function(c){
        Queuing.c = c;
    },
    k:function(k){
        Queuing.k = k;
    },
    m:function(m){
        Queuing.m = m;
    },
    Lambda:function(Lambda){
        Queuing.Lambda = Lambda;
    },
    Mu:function(Mu){
        Queuing.Mu = Mu;
    },
    LambdaUnits:function(units){
        Queuing.LambdaUnits = units;
    },
    MuUnits:function(units){
        Queuing.MuUnits = units;
    },
    ResultsUnits:function(units){
        Queuing.ResultsUnits = units;
    },
    decimals:function(units){
        Queuing.decimals = units;
    },
    n:function(units){
        Queuing.n = units;
    },
    t:function(units){
        Queuing.t = units;
    },
    tq:function(units){
        Queuing.tq = units;
    },
    All:function(){
        this.c(parseFloat($('#c').val()));
        this.k(parseFloat($('#k').val()));
        this.m(parseFloat($('#m').val()));
        this.Lambda(parseFloat($('#Lambda').val()));
        this.Mu(parseFloat($('#Mu').val()));
        this.decimals(parseFloat($('#decimals').val()));
    },
    Probabilities:function(){
        this.n(parseFloat($('#n').val()));
        this.t(parseFloat($('#t').val()));
        this.tq(parseFloat($('#tq').val()));
    }
};

// -1 -> no units, 0 -> Days, 1 -> Hours, 2 -> Minutes, 3 -> Seconds
var units = {
    getRateUnits: function(unitVal){
        switch(unitVal){
            case -1:
                return 'No Units';
                break;
            case 0:
                return 'Customers / Day';
                break;
            case 1:
                return 'Customers / Hour';
                break;
            case 2:
                return 'Customers / Minute';
                break;
            case 3:
                return 'Customers / Second';
                break;
            default:
                return ''
                break;
        }
    },
    getRateUnitsAbrev: function(unitVal){
        switch(unitVal){
            case -1:
                return 'No Units';
                break;
            case 0:
                return 'Cust/day';
                break;
            case 1:
                return 'Cust/hr';
                break;
            case 2:
                return 'Cust/min';
                break;
            case 3:
                return 'Cust/sec';
                break;
            default:
                return ''
                break;
        }
    },
    getUnits: function(unitVal, plural){
        var s = ((plural)?'s':'');
        switch(unitVal){
            case -1:
                return 'No Units';
                break;
            case 0:
                return 'Day' + s;
                break;
            case 1:
                return 'Hour' + s;
                break;
            case 2:
                return 'Minute' + s;
                break;
            case 3:
                return 'Second' + s;
                break;
            default:
                return ''
                break;
        }
    }
    //served / hour
}

var chart = {
    discreteCategories: [],
    discreteProbabilities: [],
    acumulatedProbabilities: [],
    timeBasedCategories: [],
    timeAcumProb: [],
    timeInQueueAcumProb: [],
    discrete: function(){
        for(i=0; i<10; i++){
            // Calculate discrete probabilities
            this.discreteCategories[i] = i;
            Queuing.n = i;
            Queuing.calculateProb();
            this.discreteProbabilities[i] = Stats.round(Queuing.Pn, Queuing.decimals);
            this.acumulatedProbabilities[i] = ((i===0)?Stats.round(Queuing.Pn, Queuing.decimals):Stats.round(Queuing.Pn+this.acumulatedProbabilities[i-1], Queuing.decimals));
        }
        $('#discreteProbChart').highcharts({
            chart: {
                shadow: true
            },
            title: {
                text: 'Descrete Probability <i class="fa-info-circle"></i>'
            },
            xAxis: {
                categories: this.discreteCategories,
                title:{
                    text:'Customers'
                }
            },
            yAxis: {
                title: {
                    text: 'Probability'
                }
            },
            series: [ {
                name: 'Accumulated',
                type: 'line',
                data: this.acumulatedProbabilities
            },{
                name: 'Descrete',
                type: 'bar',
                data: this.discreteProbabilities
            }]
        });
    },
    timeBased:function(){
        for(i=0; i<10; i++){
            // Calculate time-based probabilities
            this.timeBasedCategories[i] = Stats.round(Queuing.W / 5 * i,Queuing.decimals);
            Queuing.t = Queuing.tq = Queuing.W / 5 * i;
            Queuing.MMC_ProbTime();
            this.timeAcumProb[i] = Stats.round(Queuing.T,Queuing.decimals);
            this.timeInQueueAcumProb[i] = Stats.round(Queuing.Tq,Queuing.decimals);
        }
        if(Queuing.model === 1){
            $('#timeBasedProbChart').highcharts({
                chart: {
                    shadow: true
                },
                title: {
                    text: 'Time Based Probability'
                },
                xAxis: {
                    categories: this.timeBasedCategories,
                    title:{
                        text:'Time Spent'
                    }
                },
                yAxis: {
                    title: {
                        text: 'Acumulated Probability'
                    }
                },
                series: [{
                    name: 'Time in System',
                    type: 'line',
                    data: this.timeAcumProb
                }, {
                    name: 'Time in Queue',
                    type: 'line',
                    data: this.timeInQueueAcumProb
                }]
            });
        }else{
            $('#timeBasedProbChart').text('');
        }
    }
}