Getting Started:

This is a maven based framework used for Pet Swagger for Api Testing via Karate
This framework requires following prerequisites.

Pre-requisites:
 
 .Jdk 8
 .Maven
 .Karate
 .Intellij Ide
 
 
Dependencies Required:

 .karate-junit5
 .karate-apache
 .cucumber-reporting
	
Execution:
 To start the test execution
  .Open command prompt or terminal
  .Navigate to project folder and execute,

    -> mvn clean test "-DconfigPath= <path of the environment config. file>" "-tags=@<tag1,tag2>"

 For Example:
    -> mvn clean test "-DconfigPath=qa.yaml" "-Dtags=@CreateAndUpdateImageById"
		
Reporting And Outputs:
	
 Cucumber Html Reports:
  .A folder with cucumber-html-reports will be created
  .Navigate to ./target/cucumber-html-reports/
  .Open overview-features.html