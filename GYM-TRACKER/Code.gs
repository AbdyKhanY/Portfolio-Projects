/*************************************************
 * 🏋️ Gym Tracker - QR Access System
 * Author: Abdigani Mohamed
 * Description: QR-based gym check-in automation
 *************************************************/

/**************** CONFIGURATION ****************/
const CONFIG = {
  DB_SHEET: "Members_DB",
  LOG_SHEET: "Check_In_Log",
  FORM_BASE_URL:
    "https://docs.google.com/forms/d/e/1FAIpQLSc1wUMyArv6uA-aY76lC9NKC-eylOZmx-weVbdxxNiSJX1svg/viewform",
  FORM_ENTRY_ID: "entry.1137340706"
};

/**************** MAIN TRIGGER ****************/
/**
 * Automatically runs when form is submitted
 */
function onFormSubmit(e) {
  if (!e || !e.values) return;

  const memberID = e.values[1];
  if (!memberID) return;

  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const dbSheet = ss.getSheetByName(CONFIG.DB_SHEET);
  const logSheet = ss.getSheetByName(CONFIG.LOG_SHEET);

  const memberData = getMemberData(dbSheet, memberID);
  if (!memberData) return;

  // 🚫 Prevent duplicate check-in (same day)
  if (isDuplicateCheckIn(logSheet, memberID)) {
    Logger.log("Duplicate check-in blocked for: " + memberID);
    return;
  }

  logCheckIn(logSheet, memberData);
}

/**************** MEMBER LOOKUP ****************/
/**
 * Fetch member data from database
 */
function getMemberData(sheet, memberID) {
  const data = sheet.getRange(2, 1, sheet.getLastRow() - 1, 11).getValues();

  for (let i = 0; i < data.length; i++) {
    if (data[i][0] === memberID) {
      return {
        id: memberID,
        name: data[i][1],
        expiry: data[i][5],
        status: data[i][6]
      };
    }
  }
  return null;
}

/**************** DUPLICATE CHECK ****************/
/**
 * Prevent multiple entries in same day
 */
function isDuplicateCheckIn(sheet, memberID) {
  const data = sheet.getDataRange().getValues();
  const today = new Date().toDateString();

  for (let i = 1; i < data.length; i++) {
    const logDate = new Date(data[i][0]).toDateString();
    const loggedID = data[i][1];

    if (loggedID === memberID && logDate === today) {
      return true;
    }
  }
  return false;
}

/**************** LOGGING ****************/
/**
 * Append check-in record
 */
function logCheckIn(sheet, member) {
  sheet.appendRow([
    new Date(),
    member.id,
    member.name,
    member.status,
    member.expiry
  ]);
}

/**************** QR GENERATION ****************/
/**
 * Generate QR codes for all members
 */
function downloadAllQRCodes() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheet = ss.getSheetByName(CONFIG.DB_SHEET);

  const data = sheet.getRange(2, 1, sheet.getLastRow() - 1, 1).getValues();
  const folder = DriveApp.createFolder("Gym_QR_Codes_" + Date.now());

  data.forEach(row => {
    const memberID = row[0];
    if (!memberID) return;

    const qrBlob = generateQR(memberID);
    folder.createFile(qrBlob);
  });

  SpreadsheetApp.getUi().alert("✅ All QR codes generated successfully.");
}

/**
 * Generate QR for selected member
 */
function downloadSingleQR() {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(CONFIG.DB_SHEET);
  const memberID = sheet.getActiveCell().getValue();

  if (!memberID) {
    SpreadsheetApp.getUi().alert("❌ Select a Member_ID first.");
    return;
  }

  const folder = DriveApp.createFolder("Single_QR_" + memberID);
  const qrBlob = generateQR(memberID);

  folder.createFile(qrBlob);

  SpreadsheetApp.getUi().alert("✅ QR generated for: " + memberID);
}

/**
 * Core QR generator function
 */
function generateQR(memberID) {
  const formURL =
    `${CONFIG.FORM_BASE_URL}?usp=pp_url&${CONFIG.FORM_ENTRY_ID}=${encodeURIComponent(memberID)}`;

  const qrURL =
    "https://api.qrserver.com/v1/create-qr-code/?size=500x500&data=" +
    encodeURIComponent(formURL);

  return UrlFetchApp.fetch(qrURL)
    .getBlob()
    .setName(memberID + ".png");
}
