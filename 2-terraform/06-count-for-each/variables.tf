variable "user_names" {
  type        = list(any)
  description = "create iam users with three names"
  default     = ["gurumee", "brenden", "ingoo"]
}
