![catspin](https://i.chzbgr.com/full/7889062656/h10C497C8/cat-spinning-on-a-roomba "catspin")

# What is this?
*Catspin* is basically a AWS proxy tool, which rotates its IP with every request. It is based on Amazons API Gateway and uses the 'X-Forward-To' header.
*Catspin* can be used to for web-discovery and bypass IP-based blocks or slowdowns naturally. It can be chained with most tools from *burp-scanner* to *gobuster*, *dirsearch*, *wfuzz*, and various Typo3 or Wordpress-Scanner, etc.    
Basically, if you throw a HTTP Get at it, *catspin* can probably handle it. If you’re interested in the initial Blogpost for this tool, you can find it [here](https://www.rootcat.de/blog/catspin_july22/).

# Use responsible
*Catspin* is a powerful tool which can circumvent most if not all IP-based security or intrusion detection/prevention systems. As a pentesting or redteaming tool it is only to be used as such and with explicit permission by your customer/target or you own systems. Discuss the use of an IP-rotating scanning tool before your engagement and make sure to start with slow requests when conducting your test. It is always the testers responsibility to conduct a safe and efficient engagement.    

# Requirements
As this is an AWS API Gateway based tool you need an AWS account with sufficient permission to create and deploy REST API Gateway.
If you want to use the *catspin.sh* script, you also need AWS keys for your account and the *aws cli* installed.

* AWS Account (deploy via portal and Cloudformation)
* AWS Cli and AWS keys (deploy with bash-script)

# Install
*Catspin* can be installed either via the AWS Webportal or AWS Cli.
Short version:
```
git clone https://github.com/rootcathacking/catspin
bash catspin.sh -run tageturi
```

Set it up/install it with -run.   
Get the URL endpoint during installation or anytime via -info.   
Delete the stack with -kill.   


## Via portal
Log in to your AWS Account and navigate to Cloudformation > create stack > upload a template file > chose catspin.yaml. The next step will ask you for a stack name and the target, you find your endpoint URL after the stack is created in the outputs tab.

![](https://github.com/rootcathacking/catspin/blob/main/cloudformation_install.png)

## Via bash-script

Run

```
bash catspin.sh -run tageturi
```
This calls the AWS Cli, so it is required, and it uses the account and keys which are configured. Run aws configure, or edit the file in the *.aws* folder, to add/change your user credentials.

You can check the status of the deployed stack, or get the endpoint URL via:
```
bash catspin.sh -info
```
If your done with scanning, you can delete the stack by running:
```
bash catspin.sh -kill
```

# Usage examples
When *catspin* is deployed, the *catspin_deployed*-endpoint is your target, you can now direct your tools or scripts at it, e.g.
```
curl https://.../execute-api.eu-central-1.amazonaws.com/catspin_deployed/wp_admin
```
Or,
```
python3 typo3scan.py -d https://.../execute-api.eu-central-1.amazonaws.com/catspin_deployed  --vuln
```
Or,
```
./dirsearch.py -u https://.../execute-api.eu-central-1.amazonaws.com/catspin_deployed --delay=3 -F
```
Depending on your tool of choice, you might encounter 301 redirects.

You can use catspin creatively in combination with various others tool or write your own script that utilize it. 

# Catspin in action

https://github.com/rootcathacking/catspin/assets/73855105/445cac49-99c4-4f18-8ba7-f857bff385d9


# Catspin gets the zoomies
As this uses API Gateway it utilizes rate and burst limit, see [here](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-request-throttling.html). 
These are set at a default and basically set how many requests gets send at peak or in a set timeframe. The default will be good for most things, you can slow catspin down or get the zoomies if you change the values of the rate and burstlimit variables.           
If catspin gets the zoomies and knocks down your server and Ming vase, only you are to blame, so know what you are doing!
