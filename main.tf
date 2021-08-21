


resource "spinnaker_application" "my_app_demo" {
  name  = "my-app-demo"
  email = "regner@qvc.com"

  //TODO: use a dynamic block
  dynamic "permission" {
    for_each = local.spin_permission
    content {
      user     = permission.value.user
      accesses = permission.value.accesses
    }
  }


}


resource "spinnaker_pipeline" "pipeline" {
    application = spinnaker_application.my_app_demo.name
    name        = "darkpipe"
    pipeline    = file("pipelines/example.json")

}

/*
data "spinnaker_pipeline" "pipeline" {
   application = "my-app-demo"
  name        = "darkpipe"
}

*/