
module.exports = (function(){

  var travisTester = {

    test: function(test){
      console.log("testing", test);
    },

    find: function(what){
      console.log("Finding", what);
    },

  };

  return travisTester;

}());
