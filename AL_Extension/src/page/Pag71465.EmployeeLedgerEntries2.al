//GL3900 
// page 71465 "Employee Ledger Entries2"
// {//GL2024  ID dans Nav 2009 : "39001465"
//     Caption = 'Employee Ledger Entries';
//     DataCaptionFields = "Employee No.";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Employee Ledger Entry2";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Document Type"; rec."Document Type")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Employee No."; rec."Employee No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Purchaser Code"; rec."Purchaser Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Original Amount"; rec."Original Amount")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Original Amt. (LCY)"; rec."Original Amt. (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Amount (LCY)"; rec."Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Remaining Amount"; rec."Remaining Amount")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Remaining Amt. (LCY)"; rec."Remaining Amt. (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Bal. Account Type"; rec."Bal. Account Type")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Bal. Account No."; rec."Bal. Account No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pmt. Discount Date"; rec."Pmt. Discount Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pmt. Disc. Possible"; rec."Pmt. Disc. Possible")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Open; rec.Open)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("On Hold"; rec."On Hold")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("User ID"; rec."User ID")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Source Code"; rec."Source Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Reason Code"; rec."Reason Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Entry No."; rec."Entry No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Ent&ry")
//             {
//                 Caption = 'Ent&ry';
//                 /* GL2024  action(Dimensions)
//                    {
//                        Caption = 'Dimensions';
//                        Image = Dimensions;
//                        RunObject = Page 544;
//                        RunPageLink = "Table ID"=CONST(25), "Entry No."=FIELD("Entry No.");
//                        ShortCutKey = 'Ctrl+F7';
//                    }*/
//                 action("Detailed &Ledger Entries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Detailed &Ledger Entries';
//                     RunObject = page "Detailed Employee Ledg Entries";
//                     RunPageLink = "Employee Ledger Entry No." = FIELD("Entry No."), "Employee No." = FIELD("Employee No.");
//                     RunPageView = SORTING("Employee Ledger Entry No.", "Posting Date");
//                     ShortCutKey = 'Ctrl+F7';
//                 }
//             }
//             group("&Application")
//             {
//                 Caption = '&Application';
//                 action("Applied E&ntries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Applied E&ntries';
//                     RunObject = page "Employee Card Bloqued";
//                     RunPageOnRec = true;
//                 }
//                 action("Apply Entries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Apply Entries';
//                     Image = ApplyEntries;
//                     RunObject = page "Apply Employee Entries2";
//                     RunPageLink = "Employee No." = FIELD("Employee No."), Open = CONST(true);
//                     ShortCutKey = 'Ctrl+F5';
//                 }
//             }
//         }
//         area(processing)
//         {
//             action("&Navigate")
//             {
//                 ApplicationArea = all;
//                 Caption = '&Navigate';
//                 Image = Navigate;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     Navigate.SetDoc(rec."Posting Date", rec."Document No.");
//                     Navigate.RUN;
//                 end;
//             }
//         }
//     }

//     trigger OnModifyRecord(): Boolean
//     begin
//         CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", Rec);
//         EXIT(FALSE);
//     end;

//     var
//         Navigate: Page Navigate;

// }

