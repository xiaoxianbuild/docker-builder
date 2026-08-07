# n8n Docker 构建

本目录包含了 n8n 的自定义 Docker 构建配置，支持中文界面及多架构构建。

## 环境变量配置

参考官方文档：[n8n 环境变量配置](https://docs.n8n.io/deploy/host-n8n/configure-n8n/basic-configuration/use-environment-variables/)

以下是常用的 n8n 环境变量及其含义：

### 基础部署配置 (Deployment)

| 变量名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| `N8N_HOST` | String | `localhost` | n8n 运行的主机名。 |
| `N8N_PORT` | Number | `5678` | n8n 监听的 HTTP 端口。 |
| `N8N_PROTOCOL` | Enum | `http` | 访问 n8n 使用的协议 (`http` 或 `https`)。 |
| `N8N_PATH` | String | `/` | n8n 部署的根路径。 |
| `N8N_LISTEN_ADDRESS` | String | `0.0.0.0` | n8n 监听的 IP 地址。 |
| `WEBHOOK_URL` | String | - | 外部访问 webhooks 的完整基础 URL（非常重要，用于生成回调地址）。 |
| `N8N_USER_FOLDER` | String | `~/.n8n` | n8n 存储配置、数据库和密钥的目录。 |
| `N8N_ENCRYPTION_KEY` | String | - | 用于加密数据库中凭据的密钥。**建议手动设置并备份**。 |

### 数据库配置 (Database)

| 变量名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| `DB_TYPE` | Enum | `sqlite` | 数据库类型 (`sqlite`, `postgresdb`, `mysqldb`, `mariadb`)。 |
| `DB_POSTGRESDB_HOST` | String | - | PostgreSQL 主机地址。 |
| `DB_POSTGRESDB_PORT` | Number | `5432` | PostgreSQL 端口。 |
| `DB_POSTGRESDB_DATABASE` | String | `n8n` | PostgreSQL 数据库名称。 |
| `DB_POSTGRESDB_USER` | String | - | PostgreSQL 用户名。 |
| `DB_POSTGRESDB_PASSWORD` | String | - | PostgreSQL 密码。 |

### 端点配置 (Endpoints)

| 变量名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| `N8N_ENDPOINT_WEBHOOK` | String | `webhook` | Webhook 的路径前缀。 |
| `N8N_ENDPOINT_WEBHOOK_TEST` | String | `webhook-test` | 测试 Webhook 的路径前缀。 |
| `N8N_PAYLOAD_SIZE_MAX` | Number | `16` | 最大 Payload 大小 (MiB)。 |
| `N8N_METRICS` | Boolean | `false` | 是否启用 `/metrics` 端点。 |

### 安全与认证 (Security & SSO)

| 变量名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| `N8N_BASIC_AUTH_ACTIVE` | Boolean | `false` | 是否启用基础认证。 |
| `N8N_BASIC_AUTH_USER` | String | - | 基础认证用户名。 |
| `N8N_BASIC_AUTH_PASSWORD` | String | - | 基础认证密码。 |
| `N8N_SSO_OIDC_LOGIN_ENABLED` | Boolean | `false` | 是否启用 OIDC 登录。 |

### 界面与本地化 (UI & Localization)

| 变量名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| `N8N_DEFAULT_LOCALE` | String | `en` | 默认语言。在我们的镜像中默认设为 `zh-CN`。 |
| `GENERIC_TIMEZONE` | String | `Europe/Berlin` | 决定日期节点等组件使用的时区。在我们的镜像中默认设为 `Asia/Shanghai`。 |
| `TZ` | String | `UTC` | 系统的时区设置，影响日志等。在我们的镜像中默认设为 `Asia/Shanghai`。 |
| `N8N_DIAGNOSTICS_ENABLED` | Boolean | `true` | 是否共享匿名遥测数据。镜像中已设为 `false` 以保护隐私。注意：关闭此项将无法使用 Code 节点中的 Ask AI。 |
| `N8N_VERSION_NOTIFICATIONS_ENABLED` | Boolean | `true` | 是否显示新版本和安全更新通知。镜像中已设为 `false`。 |
| `N8N_TEMPLATES_ENABLED` | Boolean | `true` | 是否启用工作流模板。镜像中已设为 `false` 以减少外部连接。 |
| `N8N_PERSONALIZATION_ENABLED` | Boolean | `true` | 是否询问用户个性化调查并据此定制。镜像中已设为 `false`。 |
| `EXTERNAL_FRONTEND_HOOKS_URLS` | String | - | 外部前端钩子 URL。镜像中已设为空字符串。 |
| `N8N_DIAGNOSTICS_CONFIG_FRONTEND` | String | - | 前端诊断配置。镜像中已设为空字符串。 |
| `N8N_DIAGNOSTICS_CONFIG_BACKEND` | String | - | 后端诊断配置。镜像中已设为空字符串。 |
| `N8N_DISABLE_UI` | Boolean | `false` | 设置为 `true` 可禁用编辑器界面。 |
| `N8N_HIDE_USAGE_PAGE` | Boolean | `false` | 是否在设置中隐藏使用情况页面。 |

### 其他配置 (Execution & Logs)

| 变量名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| `EXECUTIONS_PROCESS` | Enum | `own` | 工作流执行方式 (`own` 或 `main`)。 |
| `N8N_LOG_LEVEL` | Enum | `info` | 日志级别 (`error`, `warn`, `info`, `debug`)。 |
| `N8N_LOG_OUTPUT` | Enum | `console` | 日志输出目标 (`console`, `file`)。 |

更多详细变量请参考 [n8n 官方文档 - 环境索引](https://docs.n8n.io/hosting/configuration/environment-variables/)。
