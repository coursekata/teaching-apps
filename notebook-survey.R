# ============================================================
#  survey.R
#  Hosted on GitHub. Source this file from your notebook.
#
#  To update questions or the endpoint, edit this file.
#  The notebook cell never needs to change.
# ============================================================

library(IRdisplay)

# ── 1. Configuration ─────────────────────────────────────────
APPS_SCRIPT_URL <- "https://script.google.com/macros/s/AKfycbz4YzPKkr4Q-YODk8GciYwoS84LKuBefQDQeTHBtxucfjsx2_hAreFrF-ZQA48PLchCRQ/exec"

questions <- list(
  list(id = "name",        label = "Name"),
  list(id = "institution", label = "Institution"),
  list(id = "email",       label = "Email"),
  list(id = "comments",    label = "Comments")
)

# ── 2. HTML Builder ───────────────────────────────────────────
.build_survey_html <- function(questions, endpoint) {

  ids_js <- sprintf('["%s"]',
    paste(sapply(questions, `[[`, "id"), collapse = '","'))

  input  <- "flex:1; min-width:0; height:28px; padding:0 7px; border:0.5px solid #cccccc; border-radius:4px; font-size:12px; background:#ffffff; color:#202124; box-sizing:border-box;"
  label  <- "font-size:12px; color:#666666; white-space:nowrap; flex-shrink:0;"
  labelR <- "font-size:12px; color:#666666; white-space:nowrap; flex-shrink:0; width:68px;"
  field  <- "display:flex; align-items:center; gap:6px; min-width:0;"
  btn    <- "height:28px !important; width:80px !important; margin-left:6px !important; padding:0 !important; box-sizing:border-box !important; border:2px solid #00cadb !important; border-radius:4px !important; background:transparent !important; color:#00cadb !important; font-size:12px !important; font-family:inherit !important; cursor:pointer !important; appearance:none !important; -webkit-appearance:none !important; flex-shrink:0 !important;"

  sprintf('
<div style="max-width:760px; margin:0 auto; font-family:-apple-system,BlinkMacSystemFont,\'Segoe UI\',sans-serif; width:100%%; box-sizing:border-box; padding:12px 18px 14px; background:#ffffff; border:0.5px solid #e0e0e0; border-radius:6px;">

  <div style="font-size:12px; color:#888888; margin-bottom:10px; font-style:italic;">Please sign in...</div>

  <div style="display:grid; grid-template-columns:0.8fr 1.2fr; gap:8px 12px; width:100%%; box-sizing:border-box;">

    <div style="%s">
      <label style="%s">Name</label>
      <input id="name" type="text" autocomplete="off" tabindex="1" style="%s" />
    </div>

    <div style="%s">
      <label style="%s">Institution</label>
      <input id="institution" type="text" autocomplete="off" tabindex="2" style="%s" />
      <button id="survey-btn" onclick="submitSurvey()" tabindex="5" style="%s">Submit</button>
    </div>

    <div style="%s">
      <label style="%s">Email</label>
      <input id="email" type="text" autocomplete="off" tabindex="3" style="%s" />
    </div>

    <div style="%s">
      <label style="%s">Comments</label>
      <input id="comments" type="text" autocomplete="off" tabindex="4" style="%s" />
    </div>

  </div>

  <div id="survey-status" style="font-size:11px; margin-top:8px; min-height:16px;"></div>

</div>

<script>
async function submitSurvey() {
  const ids    = %s;
  const status = document.getElementById("survey-status");
  const btn    = document.getElementById("survey-btn");
  const params = new URLSearchParams();

  for (const id of ids) {
    const val = document.getElementById(id).value.trim();
    if (!val) {
      status.style.color = "#b45000";
      status.textContent = "Please fill in all fields.";
      return;
    }
    params.append(id, val);
  }

  params.append("timestamp", new Date().toISOString());
  params.append("_fields", ids.join(","));

  btn.style.setProperty("color", "#aaaaaa", "important");
  btn.style.setProperty("border-color", "#aaaaaa", "important");
  btn.disabled = true;
  ids.forEach(id => document.getElementById(id).disabled = true);

  fetch("%s", { method: "POST", mode: "no-cors", body: params }).catch(() => {});

  status.style.color = "#1e8e3e";
  status.textContent = "\u2713 Recorded. Thank you.";
}
</script>
  ',
  field, label,  input,
  field, labelR, input, btn,
  field, label,  input,
  field, labelR, input,
  ids_js, endpoint)
}

# ── 3. Render immediately on source() ────────────────────────
display_html(.build_survey_html(questions, APPS_SCRIPT_URL))
