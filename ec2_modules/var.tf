variable "ec2_ami"{
    default="ami-04c12937e87474def"
}
variable "ec2_instance_type"{
 default="t2.micro"
}
variable "vpc_id" {
    description ="cccc"
    type = string
}   
variable "subnet_id" {
    type = string
}
variable "subnet_id1"{
    type = string
}