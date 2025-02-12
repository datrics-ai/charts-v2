{{/*
Expand the name of the chart.
*/}}
{{- define "datrics.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "datrics.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- printf "fullnameOverride: %s" .Values.fullnameOverride | quote | nindent 0 }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "datrics.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "datrics.labels" -}}
helm.sh/chart: {{ include "datrics.chart" . }}
{{ include "datrics.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "datrics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "datrics.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "datrics.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "datrics.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "fe.serviceAccountName" -}}
{{- if .Values.fe.serviceAccount.create -}}
    {{ default (printf "%s-%s" (include "datrics.fullname" .) .Values.fe.name) .Values.fe.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.fe.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "api.serviceAccountName" -}}
{{- if .Values.common.workers_mode -}}
workers-management
{{- else -}}
    {{- if .Values.api.serviceAccount.create -}}
        {{ default (printf "%s-%s" (include "datrics.fullname" .) .Values.api.name) .Values.api.serviceAccount.name | trunc 63 | trimSuffix "-" }}
    {{- else -}}
        {{ default "default" .Values.api.serviceAccount.name }}
    {{- end -}}
    {{- end -}}
{{- end -}}

{{- define "deployer.serviceAccountName" -}}
{{- if .Values.deployer.serviceAccount.create -}}
    {{ default (printf "%s-%s" (include "datrics.fullname" .) .Values.deployer.name) .Values.deployer.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.deployer.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "previewer.serviceAccountName" -}}
{{- if .Values.previewer.serviceAccount.create -}}
    {{ default (printf "%s-%s" (include "datrics.fullname" .) .Values.previewer.name) .Values.previewer.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.previewer.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "aiAnalyst.backend.serviceAccountName" -}}
{{- if .Values.aiAnalyst.backend.serviceAccount.create -}}
    {{ default (printf "%s-%s" (include "datrics.fullname" .) .Values.aiAnalyst.backend.name) .Values.aiAnalyst.backend.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.aiAnalyst.backend.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "aiAnalyst.worker.serviceAccountName" -}}
{{- if .Values.aiAnalyst.worker.serviceAccount.create -}}
    {{ default (printf "%s-%s" (include "datrics.fullname" .) .Values.aiAnalyst.worker.name) .Values.aiAnalyst.worker.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.aiAnalyst.worker.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "aiprep.serviceAccountName" -}}
{{- if .Values.aiprep.serviceAccount.create -}}
    {{ default (printf "%s-%s" (include "datrics.fullname" .) .Values.aiprep.name) .Values.aiprep.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.aiprep.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Template containing common environment variables that are used by several services.
*/}}
{{- define "datrics.commonEnv" -}}
{{- end }}


{{/*
Common annotations
*/}}
{{- define "datrics.annotations" -}}
{{- if .Values.commonAnnotations }}
{{ toYaml .Values.commonAnnotations }}
{{- end }}
helm.sh/chart: {{ include "datrics.chart" . }}
{{ include "datrics.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Define API endpoint
*/}}
{{- define "datrics.apiEndpoint" -}}
{{- if .Values.common.domain -}}
https://api.{{ .Values.common.domain }}
{{- else -}}
http://{{ include "datrics.fullname" . }}-{{ .Values.api.name }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.api.service.port }}
{{- end -}}
{{- end -}}

{{/*
Define Webapp endpoint
*/}}
{{- define "datrics.feEndpoint" -}}
{{- if .Values.common.domain -}}
https://app.{{ .Values.common.domain }}
{{- else -}}
http://{{ include "datrics.fullname" . }}-{{ .Values.fe.name }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.fe.service.port }}
{{- end -}}
{{- end -}}

{{/*
Define Ai Analyst endpoint
*/}}
{{- define "datrics.aiAnalystEndpoint" -}}
{{- if .Values.common.domain -}}
https://ai-analyst-api.{{ .Values.common.domain }}
{{- else -}}
http://{{ include "datrics.fullname" . }}-{{ .Values.aiAnalyst.name }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.aiAnalyst.backend.api.service.port }}
{{- end -}}
{{- end -}}

{{/*
Define Ai Prep endpoint
*/}}
{{- define "datrics.aiPrepEndpoint" -}}
{{- if .Values.common.domain -}}
https://ai-prep-api.{{ .Values.common.domain }}
{{- else -}}
http://{{ include "datrics.fullname" . }}-{{ .Values.aiprep.name }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.aiprep.service.port }}
{{- end -}}
{{- end -}}

{{- define "datrics.deployerEndpoint" -}}
http://{{ include "datrics.fullname" . }}-{{ .Values.deployer.name }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.deployer.service.port }}
{{- end -}}

{{/*
Define Redis host
*/}}
{{- define "datrics.redisHost" -}}
{{- if .Values.redis.enabled -}}
{{ include "datrics.fullname" . }}-redis-master
{{- else -}}
{{ .Values.common.redis.host }}
{{- end -}}
{{- end -}}

{{/*
Define Redis port
*/}}
{{- define "datrics.redisPort" -}}
{{- if .Values.redis.enabled -}}
6379
{{- else -}}
{{ .Values.common.redis.port }}
{{- end -}}
{{- end -}}

{{/*
Define Redis DB
*/}}
{{- define "datrics.redisDb" -}}
0
{{- end -}}

{{/*
Define Redis URL
*/}}
{{- define "datrics.redisUrl" -}}
redis://{{ include "datrics.redisHost" . }}:{{ include "datrics.redisPort" . }}
{{- end -}}


{{/*
Define MinIO host
*/}}
{{- define "datrics.minioHost" -}}
{{- if .Values.minio.enabled -}}
{{ include "datrics.fullname" . }}-minio
{{- else -}}
{{ .Values.common.storage.host }}
{{- end -}}
{{- end -}}

{{/*
Define MinIO port
*/}}
{{- define "datrics.minioPort" -}}
{{- if .Values.minio.enabled -}}
9000
{{- else -}}
{{ .Values.common.storage.port }}
{{- end -}}
{{- end -}}

{{/*
Define MinIO access key
*/}}
{{- define "datrics.minioAccessKey" -}}
{{- if .Values.minio.enabled -}}
{{ .Values.minio.rootUser }}
{{- else -}}
{{ .Values.common.storage.access_key }}
{{- end -}}
{{- end -}}

{{/*
Define MinIO secret key
*/}}
{{- define "datrics.minioSecretKey" -}}
{{- if .Values.minio.enabled -}}
{{ .Values.minio.rootPassword }}
{{- else -}}
{{ .Values.common.storage.secret_key }}
{{- end -}}
{{- end -}}

{{/*
Define MinIO use SSL
*/}}
{{- define "datrics.minioUseSSL" -}}
{{- if .Values.minio.enabled -}}
False
{{- else -}}
{{ .Values.common.storage.use_ssl }}
{{- end -}}
{{- end -}}

{{/*
Define MinIO bucket
*/}}
{{- define "datrics.minioBucket" -}}
{{- if .Values.minio.enabled -}}
{{ (index .Values.minio.buckets 0).name }}
{{- else -}}
{{ .Values.common.storage_bucket }}
{{- end -}}
{{- end -}}

{{/*
Define backend DB connection string (async)
*/}}
{{- define "datrics.backendDbConnectionAsync" -}}
postgresql+asyncpg://{{ .Values.common.db.username }}:{{ .Values.common.db.password }}@{{ .Values.common.db.host }}:{{ .Values.common.db.port }}/{{ .Values.common.db.db }}?ssl={{ .Values.common.db.ssl_mode }}
{{- end -}}

{{/*
Define backend DB connection string (sync)
*/}}
{{- define "datrics.backendDbConnectionSync" -}}
postgresql+psycopg2://{{ .Values.common.db.username }}:{{ .Values.common.db.password }}@{{ .Values.common.db.host }}:{{ .Values.common.db.port }}/{{ .Values.common.db.db }}?sslmode={{ .Values.common.db.ssl_mode }}
{{- end -}}


{{/*
Define AI Analyst DB connection string (async)
*/}}
{{- define "datrics.aiAnalystDbConnectionAsync" -}}
postgresql+asyncpg://{{ .Values.common.aiAnalystDb.username }}:{{ .Values.common.aiAnalystDb.password }}@{{ .Values.common.aiAnalystDb.host }}:{{ .Values.common.aiAnalystDb.port }}/{{ .Values.common.aiAnalystDb.db }}?ssl={{ .Values.common.aiAnalystDb.ssl_mode }}
{{- end -}}

{{/*
Define AI Analyst DB connection string (Celery)
*/}}
{{- define "datrics.aiAnalystDbConnectionCelery" -}}
db+postgresql://{{ .Values.common.aiAnalystDb.username }}:{{ .Values.common.aiAnalystDb.password }}@{{ .Values.common.aiAnalystDb.host }}:{{ .Values.common.aiAnalystDb.port }}/{{ .Values.common.aiAnalystDb.db }}?sslmode={{ .Values.common.aiAnalystDb.ssl_mode }}
{{- end -}}

{{/*
Define AI Prep DB connection string (sync)
*/}}
{{- define "datrics.aiPrepDbSync" -}}
postgresql+psycopg2://{{ .Values.common.aiPrepDb.username }}:{{ .Values.common.aiPrepDb.password }}@{{ .Values.common.aiPrepDb.host }}:{{ .Values.common.aiPrepDb.port }}/{{ .Values.common.aiPrepDb.db }}?sslmode={{ .Values.common.aiPrepDb.ssl_mode }}
{{- end -}}