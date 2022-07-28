terraform {
    backend "s3"{
        bucket ="new-bucket-vishanth"
        key = "lab/terraform.tfstate"
        region = "ca-central-1"
        dynamodb_table = "new_table"
    }
}