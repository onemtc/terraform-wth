# Challenge 3 - Advanced resource declarations

[< Previous Challenge](./Terraform-Challenge-02.md) - [Home](../README.md) - [Next Challenge >](./Terraform-Challenge-04.md)

## Introduction

The goals for this challenge include understanding:

- How to create a set of resources based on a list or count (loops), eg iteration

## Challenges

**Challenge:** Using your existing Terraform manifests, create a new resource that will create additional blob containers in your existing storage account.

- Create a string variable called `containernameprefix` and assign it a default value of your choice.
- Using the [count meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/count), create a single blob container resource definition that provisions three containers, naming them _prefix-[count#]_

**Challenge:** Using your existing Terraform manifests, create a(nother) blob container, but rather than using the _count_ operator:
- Create a variable called `containersuffixlist` of type _list_ and have it contain the values `a`, `b`, and `c`
- Use the [for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each) operator in conjunction with a second blob container resource definition to create three more containers with the names _prefix_-a, _prefix_-b, and _prefix_-c.

## Success Criteria

1. Use the Azure portal or Azure cli to verify new containers were added to the storage account.
