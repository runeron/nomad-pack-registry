# See https://raw.githubusercontent.com/nightscout/cgm-remote-monitor/master/docker-compose.yml
job [[ template "job_name" . ]] {
  [[- with .my.region ]]
  region = [[ . | quote ]]
  [[- end ]]
  type        = "service"
  datacenters = [[ .my.datacenters  | toStringList ]]
  
  group "application" {
    count = [[ .my.count ]]

    [[- with .my.ephemeral_disk ]]
    
    ephemeral_disk {
      migrate = [[ .migrate ]]
      sticky  = [[ .sticky ]]
      size    = [[ .size ]]
    }
    [[- end ]]

    network {
      [[- with .my.network_mode ]]
      mode = [[ . | quote ]]

      [[- end ]]

      [[- with .my.expose_port_mongo ]]
      
      port "mongo" {
        to = [[ .to ]]
        [[- if .static ]]
        static = [[ .static ]][[ end ]]
      }
      [[- end ]]

      [[- with .my.expose_port_nightscout ]]
      
      port "http" {
        to = [[ .to ]]
        [[- if .static ]]
        static = [[ .static ]][[ end ]]
      }
      [[- end ]]
    }

    [[- if .my.register_consul_service ]]
    
    service {
      name = "[[ .my.consul_service_name ]]"
      tags = [[ .my.consul_service_tags | toStringList ]]
      port = "http"
      
      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }
    [[- end ]]

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    [[- if .my.task_mongo_enabled ]]

    task "mongo" {
      driver = "docker"

      [[- with .my.task_mongo_resources ]]
      
      resources {
      [[- range $k,$v := . ]]
        [[- if $v ]]
        [[ $k ]] = [[ $v ]]
        [[- end ]]
      [[- end ]]
      }
      [[- end ]]

      [[- with .my.task_mongo_env ]]
      
      env {
      [[- range $k,$v := . ]]
        [[ $k ]] = [[ $v | quote ]]
      [[- end ]]
      }
      [[- end ]]

      config {
        image = [[ .my.task_mongo_image | quote ]]
        
        [[- with .my.expose_port_mongo ]]
        
        ports = [
          "mongo",
        ]
        [[- end ]]
      }
    }
    [[- end ]]

    task "nightscout" {
      driver = "docker"

      [[- with .my.task_nightscout_resources ]]
      
      resources {
      [[- range $k,$v := . ]]
        [[- if $v ]]
        [[ $k ]] = [[ $v ]]
        [[- end ]]
      [[- end ]]
      }
      [[- end ]]

      [[- with .my.task_nightscout_env ]]
      
      env {
      [[- range $k,$v := . ]]
        [[ $k ]] = [[ $v | quote ]]
      [[- end ]]
      }
      [[- end ]]
      
      config {
        image = [[ .my.task_nightscout_image | quote ]]
        
        ports = [
          "http",
        ]
      }
    }
  }
}
