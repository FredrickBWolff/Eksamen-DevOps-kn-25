terraform {
    backend "s3" {
        bucket       = "pgr301-terraform-state"
        key          = "whisifai/25/terraform.tfstate"
        region       = "eu-west-1"
        use_lockfile = true
        encrypt      = true
    }
}