resource "shoreline_notebook" "scheduled_postgresql_data_backups_failing" {
  name       = "scheduled_postgresql_data_backups_failing"
  data       = file("${path.module}/data/scheduled_postgresql_data_backups_failing.json")
  depends_on = [shoreline_action.invoke_clean_old_backups]
}

resource "shoreline_file" "clean_old_backups" {
  name             = "clean_old_backups"
  input_file       = "${path.module}/data/clean_old_backups.sh"
  md5              = filemd5("${path.module}/data/clean_old_backups.sh")
  description      = "Clean up the PostgreSQL backups more than a week old to free disk space"
  destination_path = "/tmp/clean_old_backups.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_clean_old_backups" {
  name        = "invoke_clean_old_backups"
  description = "Clean up the PostgreSQL backups more than a week old to free disk space"
  command     = "`chmod +x /tmp/clean_old_backups.sh && /tmp/clean_old_backups.sh`"
  params      = ["BACKUP_LOCATION"]
  file_deps   = ["clean_old_backups"]
  enabled     = true
  depends_on  = [shoreline_file.clean_old_backups]
}

