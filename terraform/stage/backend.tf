terraform {
  backend "gcs" {
    bucket = "pp_tf_state_stage"
    prefix = "terraform/state"
  }
}
