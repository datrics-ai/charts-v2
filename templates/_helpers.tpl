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