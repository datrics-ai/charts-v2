{{- define "datrics.aiAnalyst.env_vars" -}}
- name: DB_URL
  value: {{ .Values.aiAnalyst.config.db_connection_string | quote }}
- name: CELERY_BACKEND
  value: {{ .Values.aiAnalyst.config.celery_db_connection_string | quote }}
- name: BACKEND_DB_URl
  value: {{ .Values.aiAnalyst.config.backend_db_connection_string | quote }}
- name: OPENAI_API_KEY
  value: {{ .Values.aiAnalyst.config.openai_api_key | quote }}
- name: AZURE_ENDPOINT
  value: {{ .Values.aiAnalyst.config.azure_endpoint | quote }}
- name: API_TYPE
  value: {{ .Values.aiAnalyst.config.api_type | quote }}
- name: AZURE_DEPLOYMENT
  value: {{ .Values.aiAnalyst.config.azure_deployment | quote }}
- name: AZURE_OPENAI_VERSION
  value: {{ .Values.aiAnalyst.config.azure_openai_version | quote }}
- name: LANGCHAIN_API_KEY
  value: {{ .Values.aiAnalyst.config.langchain.api_key | quote }}
- name: LANGCHAIN_TRACING_V2
  value: {{ .Values.aiAnalyst.config.langchain.tracing_enabled | quote }}
- name: LANGCHAIN_ENDPOINT
  value: {{ .Values.aiAnalyst.config.langchain.endpoint | quote }}
- name: REDIS_URL
  value: {{ .Values.aiAnalyst.config.redis_url | quote }}
- name: USE_STORAGE
  value: {{ .Values.aiAnalyst.config.storage.enabled | quote }}
- name: STORAGE_HOST
  value: {{ (printf "%s:%s" .Values.aiAnalyst.config.storage.host .Values.aiAnalyst.config.storage.port) | quote }}
- name: STORAGE_ACCESS_KEY
  value: {{ .Values.aiAnalyst.config.storage.access_key | default .Values.minio.rootUser | quote }}
- name: STORAGE_SECRET_KEY
  value: {{ .Values.aiAnalyst.config.storage.secret_key | default .Values.minio.rootPassword | quote }}
- name: STORAGE_IS_SECURE
  value: {{ .Values.aiAnalyst.config.storage.use_ssl | quote }}
- name: STORAGE_BUCKET
  value: {{ .Values.aiAnalyst.config.storage.bucket | quote }}
- name: BASE_URL
  value: {{ .Values.aiAnalyst.config.base_url | quote }}
{{- end -}}