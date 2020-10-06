# variables.tf
variable "access_key" {
     default = "AKIAT5Z4HIBYIDFIZEP5"
}
variable "secret_key" {
     default = "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"
}
variable "region" {
     default = "ap-south-1"
}
variable "availabilityZone1" {
     default = "ap-south-1a"
}
variable "availabilityZone2" {
     default = "ap-south-1b"
}
variable "availabilityZone3" {
     default = "ap-south-1c"
}
variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "PrivateSubnet-A" {
    default = "10.0.100.0/24"
}
variable "PrivateSubnet-B" {
    default = "10.0.101.0/24"
}
variable "PrivateSubnet-C" {
    default = "10.0.102.0/24"
}
variable "PublicSubnet-A" {
    default = "10.0.110.0/24"
}
variable "PublicSubnet-B" {
    default = "10.0.111.0/24"
}
variable "PublicSubnet-C" {
    default = "10.0.112.0/24"
}

variable "destinationCIDRblock" {
    default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
    default = true
}
# end of variables.tf