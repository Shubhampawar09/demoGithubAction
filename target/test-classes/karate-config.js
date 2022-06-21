function fn() {
    var env = karate.env; // get system property 'karate.env'

    if(!karate.properties['configPath']){
        karate.log(java.lang.String.format("Terminating execution due to %s config file path",
        karate.properties['configPath']))
        java.lang.System.exit(0);
    }

    var envProps = karate.read('file:' + karate.properties['configPath']);
    var path = karate.read('file:constants/common.yaml');

  try{

   var config = {
         env : env,
         basicAuthorization: envProps.basicAuthorization,
         retryCount : 30,
         retryInterval : 10000 //ms
   };

        config.envHost = envProps.host
        config.sampleUrlget = envProps.host + path.endPoints.sample.get;
        config.uiUrl = envProps.url
//      config.baseurl = envProps.baseUrl + path.endPoints.getPetById.get
        config.baseurl = envProps.baseUrl

        var driverConfig = { type: 'chrome', headless: false, addOptions: [ '--disable-geolocation', '--start-maximized', '--disable-notifications'], prefs : { 'profile.default_content_setting_values.geolocation': 2} };
        karate.configure('driver', driverConfig);
        config.driverConfig = driverConfig;

    karate.log('karate.env:', env);

    karate.configure('readTimeout', 120000);

    return config;
    }catch(e){
        karate.log(java.lang.String.format("Terminating execution due to %s in configuration", e))
        java.lang.System.exit(0);
    }
}