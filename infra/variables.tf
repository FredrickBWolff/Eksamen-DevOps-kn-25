variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "kandidatnummer" {
  type    = string
  default = "25"
}

variable "ecr_repository" {
  type    = string
  default = "fb-eksamen2026-25"
}

variable "image_tag" {
  type    = string
  default = "b637dc7"
}