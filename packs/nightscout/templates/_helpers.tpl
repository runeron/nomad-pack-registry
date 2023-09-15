// allow nomad-pack to set the job name
[[ define "job_name" ]]
[[- if eq .my.job_name "" -]]
[[- .nomad_pack.pack.name | quote -]]
[[- else -]]
[[- .my.job_name | quote -]]
[[- end ]]
[[- end ]]
