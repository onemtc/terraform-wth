# Challenge 9 - Configure VM Scale Set to run a Web Server

[< Previous Challenge](./Terraform-Challenge-08.md) - [Home](../README.md) - [Next Challenge>](./Terraform-Challenge-10.md)

## Introduction

This challenge will build on our ACA deployment from the prior exercise.  We will deploy an Azure App Gateway and configure it to route traffic to our ACA.

## Description

For this challenge, you'll add to the code you already created.

+ Provision an [Azure App Gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway)
    - Configure the App Gateway to use the [WAF_v2 SKU](https://docs.microsoft.com/en-us/azure/application-gateway/waf-overview)


## Success Criteria

1. Verify you can view the web page configured by the script

## Learning Resources

- [Protect Azure Container Apps with Web Application Firewall on Application Gateway](https://learn.microsoft.com/en-us/azure/container-apps/waf-app-gateway?tabs=default-domain)
- Read a text file using a [Linux shell](https://askubuntu.com/questions/261900/how-do-i-open-a-text-file-in-my-terminal)
