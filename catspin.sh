#!/bin/bash

case "$1" in
  "-run")
    uri=$2

    echo "Deploying catspin"
    aws cloudformation create-stack --template-body file://catspin.yaml --stack-name catspin --parameters ParameterKey=uri,ParameterValue=$uri --output text
    echo "for target: $uri"
    sleep 3
    echo "Done
    sleep 5
    echo "Sleeping a liddle"
    sleep 8
    echo "Catspin runs under: "
    aws cloudformation describe-stacks --stack-name catspin  --query Stacks[*].Outputs --output text
    echo "or check -info, in case the stack is not finished yet"
    ;;

  "-kill")
    echo "Stack is beeing deleted this takes up to a few minutes"
    aws cloudformation delete-stack --stack-name catspin --output text
    aws cloudformation describe-stacks --stack-name catspin --query Stacks[*].StackStatus --output text
    ;;

  "-info")
    echo "Stack status:"
    aws cloudformation describe-stacks --stack-name catspin --query Stacks[*].StackStatus --output text
    echo 'Outputs'
    aws cloudformation describe-stacks --stack-name catspin  --query Stacks[*].Outputs --output text
    ;;

  *)
    echo You spin my gato round right round ...
    echo Use -run and then the uri of your target
    echo Use -info to get stack status and enpoint URL of catspin
    echo Use -kill to delete catspin and its stack
    exit 1
    ;;
esac
