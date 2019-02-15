# okta-aws-cli-authentication
docker container with everything you need installed to authenticate terraform, aws cli through okta. 
Preqs:
Docker Installed
AWS Cli installed


Steps:
create a file called config.properties and add the following information:
#OktaAWSCLI
OKTA_ORG=<add your okta organization>
OKTA_AWS_APP_URL=<add the okta aws app url for the account you are logging into>
OKTA_USERNAME=<add your okta username>
OKTA_BROWSER_AUTH=false

#you will be mounting this file along with your .aws directory to the container in a later step.


open terminal and run:

git clone https://github.com/jgearheart/okta-aws-cli-authentication.git <br />
cd okta-aws-cli-authentication <br />
docker build -t okta-aws .
#Once the container image is built:
docker run -tid -v $HOME/.aws:/root/.aws -v  ~/.okta/config.properties:/root/.okta/config.properties --name okta-aws okta-aws
<br /><br />#Now simply run the command below to authenticate to okta <br />
#and pass in the aws cred profile name you want to use (using devops as the aws credential profile name below).<br />
docker exec -ti okta-aws  bash  -c "./getcreds.sh devops" <br />
#you should be prompted for your okta password and mfa if used.
#Once complete you should have temporary creds for the aws account you added in the OKTA_AWS_APP_URL in your ~/.aws/credentials file with a profile name of devops on your host machine <br />
#to test simply run: aws sts get-caller-identity --profile devops
