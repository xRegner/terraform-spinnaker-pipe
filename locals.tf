locals {
  spin_permission = [
    {
      user     = "develop"
      accesses = ["READ", "EXECUTE"]
    },
    {
      user     = "anonymous"
      accesses = ["READ"]
  },
  {
      user     = "local"
      accesses = ["READ", "WRITE"]
  }]
}
