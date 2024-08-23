{{- define "datrics.previewer.env_vars" -}}
- name: MINIO_HOST_URL
  value: {{ .Values.previewer.config.storage.host | quote }}
- name: MINIO_HOST_IS_SECURE
  value: {{ .Values.previewer.config.storage.use_ssl | quote }}
- name: MINIO_ACCESS_KEY
  value: {{ .Values.previewer.config.storage.access_key | default .Values.minio.rootUser | quote }}
- name: MINIO_SECRET_KEY
  value: {{ .Values.previewer.config.storage.secret_key | default .Values.minio.rootPassword | quote }}
- name: CACHE_REDIS_ENABLED
  value: {{ .Values.previewer.config.redis_cache_enabled | quote }}
- name: FS_CACHE_DIR
  value: {{ .Values.previewer.config.fs_cache_dir | quote }}
- name: CACHE_ENABLED
  value: {{ .Values.previewer.config.cache_enabled | quote }}
{{- end -}}