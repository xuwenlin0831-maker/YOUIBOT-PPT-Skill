# YOUIBOT PPT Skill

用于生成 YOUIBOT 公司格式演示文稿的 Codex Skill。它把需求确认、页级大纲审批、可批注 HTML 审阅和原生可编辑 PPTX 交付固化为一套流程。

## 核心约束

- 资料不完整也可以开始，但必须先检查资料并集中补问缺失信息。
- Gate 1：需求简报和页级大纲得到明确确认后，才可生成 HTML。
- Gate 2：只有收到“HTML已定稿，可以生成PPT”等明确授权后，才可生成 PPTX。
- 首页默认保留半年述职模板的官方产业场景图；仅在 Gate 1 明确批准时更换专题视觉。
- 支持“培训/SOP型”和“汇报/数据型”；数据缺少单位、周期、目标、对比基准或来源时必须追问。
- 最终文字、形状、表格、图表和备注保持原生可编辑，不用整页截图伪装幻灯片。

## 安装

### 方式一：手动复制

1. 下载本仓库 ZIP 并解压。
2. 将 `artifact-template-youibot-ppt` 整个文件夹复制到：

   `%USERPROFILE%\.codex\skills\artifact-template-youibot-ppt`

3. 重新启动 Codex。

完整步骤见 [安装SOP](docs/INSTALL.md)。

### 方式二：使用 `$skill-installer`

在 Codex 中发送：

```text
使用 $skill-installer 安装：
https://github.com/xuwenlin0831-maker/YOUIBOT-PPT-Skill/tree/main/artifact-template-youibot-ppt
```

安装完成后重新启动 Codex。

## 首次调用

```text
使用最新版 $artifact-template-youibot-ppt 制作公司格式 PPT。

PPT主题：
使用目的：
主要受众：
资料路径：
必须包含的内容：

请先读取资料并补问缺失信息。确认需求和页级大纲后再生成 HTML；在我明确确认 HTML 定稿前，不生成 PPTX。
```

调用信息可以不填完整。Skill 会先检查现有资料，再补问影响内容真实性或结构的缺失项。

## 仓库结构

- `artifact-template-youibot-ppt/`：可直接安装的 Skill。
- `docs/`：安装与验证说明。
- `training/`：培训材料及 Gate 1 方案。
- `demos/`：已验证案例和未来数据案例入口。
- `tools/`：发布副本构建工具。
- `validation/`：发布验证说明与结果。

## 当前状态

培训材料 v0.2 正在执行两道审批门槛。仓库先发布可安装 Skill、安装说明和案例入口；HTML、Word 和 PPTX 将在对应门槛通过后加入。未经明确的 Gate 2 授权不会生成培训 PPTX。

## 权利说明

本仓库暂未提供开源许可证。除非权利人另行书面授权，不授予复制、修改、分发或商业使用许可。

