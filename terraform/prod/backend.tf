terraform {
  backend "gcs" {
    bucket = "pp_tf_state_prod"
    prefix = "terraform/state"
  }
}
