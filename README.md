
![catspin](https://i.chzbgr.com/full/7889062656/h10C497C8/cat-spinning-on-a-roomba "catspin")

# What is this?
*Catspin* is basically a AWS proxy tool, which rotates its IP every request. It is based on Amazons API Gateway and uses the 'X-Forward-To' header.
*Catspin* can be used to for web-discovery and bypass IP-based blocks or slowdowns naturally. It can be chained with most tools from *burp-scanner* to *gobuster*, *dirsearch*, *wfuzz*, and various Typo3 or Wordpress-Scanner, etc. Basically, if you throw a HTTP Get at it, *catspin* can probably handle it. If your interested in the accompanying Blogpost for this tool, you can find it [here](https://www.rootcat.de/blog/catspin_july22/).

# Use responsible
*Catspin* is a powerful tool which can circumvent most if not all IP-based security or intrusion detection/prevention systems. As a pentesting tool it is only to be used as such and with explicit permission by your customer/target or you own systems. Discuss the use of an IP-rotating scanning tool before your engagement and make sure to start with slow requests when conducting your test. It is always the pentesters responsibility to conduct a safe and efficient engagement.

# Requirements
As this is an AWS API Gateway based tool you need an AWS account with sufficient permission to create and deploy REST API Gateway.
If you want to use the *catspin.sh* script you also need AWS keys for your account and the *aws cli* installed.

* AWS Account (deploy via portal and Cloudformation)
* AWS Cli and AWS keys (deploy with bash-script)

# Install
*Catspin* can be installed either via the AWS Webportal or AWS Cli.
Short version:
```
git clone https://github.com/rootcathacking/catspin
bash catspin.sh -run tageturi
```
Install, get url endpoint during installation or via -info, delete stack with -kill.


## Via portal
Log in to your AWS Account and navigate to Cloudformation > create stack > upload a template file > chose catspin.yaml. The next step will ask you for a stackname and the target, you find your endpoint URL after the stack is created in the outputs tab.

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
If your done with scanning, you can delete the stack by running
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
vane scan --url https://.../execute-api.eu-central-1.amazonaws.com/catspin_deployed
```
Or,
```
./dirsearch.py -u https://.../execute-api.eu-central-1.amazonaws.com/catspin_deployed --delay=3 -F
```
Depending on your tool of choice, you might encounter 301 redirects.

The example directory scan from above, would look something like this on the webserver logs

![](https://github.com/rootcathacking/catspin/blob/main/scan_example.png)

You can also add the *catspin* endpoint to burp and use it from there, or use it creatively in combination with various other tools in the pentester arsenal.
