{{- define "datrics.api.env_vars" -}}
- name: APP_DOMAIN
  value: {{ .Values.common.domain | quote }}
- name: BASE_URL
  value: {{ include "datrics.apiEndpoint" . | quote }}
- name: FE_BASE_URL
  value: {{ include "datrics.feEndpoint" . | quote }}
- name: APP_CHAT_AI_ANALYST_URL
  value: {{ include "datrics.aiAnalystEndpoint" . | quote }}
- name: NODE_ENV
  value: {{ .Values.api.config.node_env | quote }}
- name: HOST
  value: {{ .Values.api.config.host | quote }}
- name: PORT
  value: {{ .Values.api.config.port | quote }}
- name: SESSION_SECRET
  value: {{ .Values.api.config.session_secret | quote }}
- name: DB_HOST
  value: {{ .Values.common.db.host | quote }}
- name: DB_PORT
  value: {{ .Values.common.db.port | quote }}
- name: DB_USERNAME
  value: {{ .Values.common.db.username | quote }}
- name: DB_PASSWORD
  value: {{ .Values.common.db.password | quote }}
- name: DB
  value: {{ .Values.common.db.db | quote }}
- name: DB_SSL_MODE
  value: {{ .Values.common.db.ssl_mode | quote }}  
- name: DB_CONNECTION_NAME
  value: {{ .Values.api.config.db.connection_name | default "production"  | quote }}  
- name: REDIS_HOST
  value: {{ include "datrics.redisHost" . | quote }}
- name: REDIS_PORT
  value: {{ include "datrics.redisPort" . | quote }}
- name: REDIS_DB
  value: {{ include "datrics.redisDb" . | quote }}
- name: STORAGE_HOST
  value: {{ include "datrics.minioHost" . | quote }}
- name: STORAGE_PORT
  value: {{ include "datrics.minioPort" . | quote }}
- name: STORAGE_ACCESS_KEY
  value: {{ include "datrics.minioAccessKey" . | quote }}
- name: STORAGE_SECRET_KEY
  value: {{ include "datrics.minioSecretKey" . | quote }}
- name: STORAGE_USE_SSL
  value: {{ include "datrics.minioUseSSL" . | quote }}
- name: STORAGE_BUCKET
  value: {{ include "datrics.minioBucket" . | quote }}
- name: SENDER_EMAIL
  value: {{ .Values.api.config.email.sender_email | quote }}
- name: MAIL_API_KEY
  value: {{ .Values.api.config.email.mailgun.apiKey | quote }}
- name: MAIL_DOMAIN
  value: {{ .Values.api.config.email.mailgun.domain | quote }}
- name: MAILCHIMP_API_KEY
  value: {{ .Values.api.config.email.mailchimp.apiKey | quote }}
- name: MAILCHIMP_LIST_ID
  value: {{ .Values.api.config.email.mailchimp.listId | quote }}
- name: DEPLOYMENT_SCHEDULER_API_BASE_URL
  value: {{ include "datrics.deployerEndpoint" . | quote }}
- name: FE_ROUTE_SIGN_IN
  value: /signin
- name: FE_ROUTE_RESET_PASSWORD
  value: /reset-password
- name: FE_ROUTE_CONFIRM_EMAIL
  value: /signup/check-inbox
- name: PRIVATE_PLAN
  value: {{ .Values.api.config.private_plan | default "Enterprise" | quote }}
- name: SENTRY_DSN
  value: {{ .Values.api.config.sentry_dsn | quote }}
- name: DEFAULT_PIPELINE_VERSION
  value: {{ .Values.api.config.default_pipeline_version | default .Values.images.pipelineImage.tag | quote }}
- name: WORKERS_MODE
  value: {{ .Values.common.workers_mode | quote }}
- name: EFS_DIRECTORY # always const
  value: /app-efs
- name: ENV
  value: {{ .Values.common.env | quote }}  
- name: WORKER_DOWNSCALE
  value: {{ .Values.api.config.workers.downscale | default "false" | quote }} 
- name: CLOUD_SERVICE
  value: {{ .Values.api.config.workers.cloud_service | quote }}  # managed-premium for azure
- name: CHAT_SERVICE_API_BASE_URL
  value: http://{{ include "datrics.fullname" . }}-{{ .Values.aiprep.name }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.aiprep.service.port }}
- name: CHAT_SERVICE_API_BASE_URL_V2
  value: http://{{ include "datrics.fullname" . }}-{{ .Values.aiAnalyst.name }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.aiAnalyst.backend.api.service.port }}
{{- end -}}