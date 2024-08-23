{{- define "datrics.api.env_vars" -}}
- name: BASE_URL
  value: {{ .Values.common.api_base_url | quote }}
- name: FE_BASE_URL
  value: {{ .Values.common.fe_base_url | quote }}
- name: APP_DOMAIN
  value: {{ .Values.common.domain | quote }}
- name: APP_CHAT_AI_ANALYST_URL
  value: {{ .Values.aiAnalystIngress.hostname | quote }}
- name: NODE_ENV
  value: {{ .Values.api.config.node_env | quote }}
- name: HOST
  value: {{ .Values.api.config.host | quote }}
- name: PORT
  value: {{ .Values.api.config.port | quote }}
- name: SESSION_SECRET
  value:  {{ .Values.api.config.session_secret | quote }}
- name: DB_HOST
  value:  {{ .Values.api.config.db.host | quote }}
- name: DB_PORT
  value:  {{ .Values.api.config.db.port | default "5432" | quote }}
- name: DB_USERNAME
  value:  {{ .Values.api.config.db.username | quote }}
- name: DB_PASSWORD
  value: {{ .Values.api.config.db.password | quote }}
- name: DB
  value: {{ .Values.api.config.db.db | quote }}
- name: DB_CONNECTION_NAME
  value: {{ .Values.api.config.db.connection_name | default "production"  | quote }}  
- name: DB_SSL_MODE
  value: {{ .Values.api.config.db.ssl_mode | quote }}  
- name: REDIS_HOST
  value: {{ .Values.api.config.redis.host | quote }}
- name: REDIS_PORT
  value: {{ .Values.api.config.redis.port | quote }}
- name: REDIS_DB
  value: {{ .Values.api.config.redis.db | quote }}      
- name: STORAGE_HOST
  value: {{ .Values.api.config.storage.host | quote }}
- name: STORAGE_PORT
  value: {{ .Values.api.config.storage.port | quote }}
- name: STORAGE_ACCESS_KEY
  value: {{ .Values.api.config.storage.access_key | default .Values.minio.rootUser | quote }}
- name: STORAGE_SECRET_KEY
  value: {{ .Values.api.config.storage.secret_key | default .Values.minio.rootPassword | quote }}
- name: STORAGE_USE_SSL
  value: {{ .Values.api.config.storage.use_ssl | quote }}
- name: STORAGE_BUCKET
  value: {{ .Values.api.config.storage.bucket | quote }}
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
  value: {{ .Values.common.deployer_base_url | quote }}
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
  value: {{ .Values.api.config.default_pipeline_version | quote }}
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
  value: http://datrics-aiprep.datrics.svc.cluster.local:8000
- name: CHAT_SERVICE_API_BASE_URL_V2
  value: http://datrics-ai-analyst.datrics.svc.cluster.local:8000
{{- end -}}