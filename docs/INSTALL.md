# 安装与验证 SOP

## 安装前检查

- 已安装并能够正常启动 Codex。
- 能访问本仓库；如果采用手动方式，能下载 ZIP。
- 目标目录中不存在同名 Skill，或已先备份旧版本。

## 方式一：手动复制

### 操作

1. 在仓库页面选择下载 ZIP，并解压到临时目录。
2. 找到解压后的 `artifact-template-youibot-ppt` 文件夹。
3. 在文件资源管理器地址栏输入 `%USERPROFILE%\.codex\skills`。
4. 将整个 `artifact-template-youibot-ppt` 文件夹复制进去。
5. 重新启动 Codex。

### 预期结果

目标目录存在 `artifact-template-youibot-ppt\SKILL.md`、`assets`、`references` 和 `scripts`。

### 常见失败与处理

- 出现双层目录：若路径变成 `artifact-template-youibot-ppt\artifact-template-youibot-ppt\SKILL.md`，将内层目录上移一层。
- 目标已存在：先备份旧目录，再复制新版；不要混合覆盖不同版本。
- 重启后仍不可用：确认 `SKILL.md` 位于 Skill 根目录，并完全退出后重新启动 Codex。

## 方式二：使用 `$skill-installer`

### 操作

在 Codex 中发送：

```text
使用 $skill-installer 安装：
https://github.com/xuwenlin0831-maker/YOUIBOT-PPT-Skill/tree/main/artifact-template-youibot-ppt
```

安装完成后重新启动 Codex。

### 预期结果

Codex 提示安装成功，且本地 Skill 根目录中出现 `artifact-template-youibot-ppt`。

### 常见失败与处理

- 无法访问 GitHub：检查网络或改用手动下载 ZIP。
- 目标目录已存在：安装器会停止，先备份或移除旧版本后重试。
- 下载到仓库根目录而非 Skill 子目录：确认链接以 `/tree/main/artifact-template-youibot-ppt` 结尾。

## 安装验证

重新启动后发送：

```text
使用最新版 $artifact-template-youibot-ppt。请只说明你的两道审批门槛、默认首页规则和两种内容模式，不要生成任何文件。
```

通过标准：

- 回答包含 Gate 1：先确认需求简报和页级大纲。
- 回答包含 Gate 2：HTML 明确定稿后才生成 PPTX。
- 回答说明首页默认保留官方产业场景图。
- 回答能区分“培训/SOP型”和“汇报/数据型”。

