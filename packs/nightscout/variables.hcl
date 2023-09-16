////////////////////////
// Job Variables
////////////////////////

variable "job_name" {
  description = "The name to use as the job name which overrides using the pack name"
  type        = string
  default     = ""
}

variable "region" {
  description = "The region where jobs will be deployed"
  type        = string
  default     = null
}

variable "namespace" {
  description = "The nomad namespace where jobs will be deployed"
  type        = string
  default     = null
}

variable "datacenters" {
  description = "A list of datacenters in the region which are eligible for task placement"
  type        = list(string)
  default     = ["dc1"]
}

variable "constraints" {
  type = list(object({
    attribute = string
    operator = string
    value    = string
  }))
  
  default     = []
}

////////////////////////
// Consul Service
////////////////////////

variable "register_service" {
  description = "If you want to register a service for the job"
  type        = bool
  default     = true
}

variable "service_provider" {
  description = "The service provider (nomad or consul)"
  type        = string
  default     = "nomad"
}

variable "service_name" {
  description = "The service name for the nightscout application"
  type        = string
  default     = "nightscout"
}

variable "service_tags" {
  description = "The service tags for the nightscout application"
  type        = list(string)
  
  default = [
    "traefik.enable=false",
  ]
}

////////////////////////
// Group Variables
////////////////////////

variable "count" {
  description = "The number of app instances to deploy"
  type        = number
  default     = 1
}

variable "ephemeral_disk" {
  description = "Enable ephemeral data-disk (/alloc/data/)"
  
  type = object({
    migrate = bool
    sticky  = bool
    size    = number
  })
  
  default = null
}

variable "network_mode" {
  type    = string
  default = "bridge"
}

variable "expose_port_mongo" {
  type = object({
    to     = number
    static = number
  })
  
  default = {
    to     = 27017
    static = null
  }
}

variable "expose_port_nightscout" {
  type = object({
    to     = number
    static = number
  })
  
  default = {
    to     = 1337
    static = null
  }
}

////////////////////////
// Task Variables | mongo
////////////////////////

variable "task_mongo_enabled" {
  description = "Create local mongo database instance."
  type        = bool
  default     = true
}

variable "task_mongo_image" {
  description = "See \"https://github.com/docker-library/mongo/issues/485\" for AVX issue. Use \"nertworkweb/mongodb-no-avx\" as alternative."
  
  type    = string
  default = "mongo:4.4.6"
}

variable "task_mongo_env" {
  type = map(string)
  
  default = {
    NS_MONGO_DATA_DIR  = "/data/db"
  }
}

variable "task_mongo_resources" {
  type = object({
    cpu        = number
    memory     = number
    memory_max = number
  })
  
  default = {
    cpu        = 100
    memory     = 128
    memory_max = null
  }
}

////////////////////////
// Task Variables | nightscout
////////////////////////

variable "task_nightscout_image" {
  type    = string
  default = "nightscout/cgm-remote-monitor:latest"
}

variable "task_nightscout_env" {
  description = "See https://nightscout.github.io/nightscout/setup_variables/ for nightscout variables"
  type = map(string)
  
  default = {
    NODE_ENV           = "production"
    TZ                 = "Etc/UTC"
    INSECURE_USE_HTTP  = "true"
    MONGO_CONNECTION   = "mongodb://127.0.0.1:27017/nightscout"
    API_SECRET         = "change_me_12"
    ENABLE             = "careportal rawbg iob"
    AUTH_DEFAULT_ROLES = "denied"
  }
}

variable "task_nightscout_resources" {
  type = object({
    cpu        = number
    memory     = number
    memory_max = number
  })
  
  default = {
    cpu        = 100
    memory     = 128
    memory_max = null
  }
}
