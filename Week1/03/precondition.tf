variable "file_name" {
  default = "step0.txt"
}

resource "local_file" "abc" {
  content  = "lifecycle - step 6"
  filename = "${path.module}/${var.file_name}"

  lifecycle {
    precondition {
      condition     = contains(["step0.txt", "step1.txt", "step2.txt", "step3.txt", "step4.txt", "step5.txt", "step6.txt"], var.file_name)
      error_message = "file name is not step0~6"
    }
  }
}