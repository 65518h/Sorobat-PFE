//GL2024 NEW Page
page 50372 "Lettrage écritures comptables"
{
    Caption = 'Lettrage écritures comptables';
    DataCaptionExpression = GetCaption();
    ObsoleteState = Pending;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    Permissions = TableData "G/L Entry" = rimd;
    SourceTable = "G/L Entry";
    SourceTableView = SORTING("G/L Account No.", "Posting Date");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'N° séquence';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Date comptabilisation';
                }
                field("Date D'échéance Ligne"; Rec."Date D'échéance Ligne")
                {
                    ApplicationArea = Basic, Suite;

                    Caption = 'Date D''échéance Ligne';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Type document';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Type document';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Basic, Suite;

                    Caption = 'Code journal';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Description';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'N° doc. externe';
                }

                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'N° origine';
                }
                field(salarie; Rec.salarie)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'salarie';
                }
                field(Letter; Rec.Letter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lettre';
                }
                field("Letter Date"; Rec."Letter Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date de la lettre';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ID lettrage';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Montant (DL)';
                }



                field("Date D'echeance"; Rec."Date D'echeance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Date Echeance';
                }

                // field("Affectation Client"; Rec."Affectation Client")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                //     Caption = 'Affectation Client';
                // }

                // field("Nom Client"; Rec."Nom Client")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                //     Caption = 'Nom Client';
                // }

                field(Lettre; Rec.Lettre)
                {
                    ApplicationArea = Basic, Suite;

                    Caption = 'Lettre Hist';
                }

            }
            group(Control1120000)
            {
                ShowCaption = false;
                field("Applies-to ID balance"; gApply)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Solde ID lettrage';

                }
                field("Applies-to ID1"; gApplyCode)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'ID lettrage';

                }
                field(ApplnCode; ApplnCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Code lettrage';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        GLEntry.Reset();
                        GLEntry.SetRange(Letter, Rec.Letter);
                        PAGE.RunModal(PAGE::"General Ledger Entries", GLEntry);
                    end;
                }
                field(Debit; Debit)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Caption = 'Débit DS';
                    Editable = false;
                }
                field(Credit; Credit)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Caption = 'Crédit (DS)';
                    Editable = false;
                }
                field("Debit - Credit"; Debit - Credit)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Caption = 'Solde';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Set Applies-to ID")
            {
                ApplicationArea = Basic, Suite;

                Caption = 'Lettrer';
                Image = SelectLineToApply;
                ShortCutKey = 'F7';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    SetAppliesToIDField(true);
                end;
            }
            action("Set Applies-to ID (All)")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Définir ID lettrage (Tous)';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    SetAppliesToIDField(false);
                end;
            }
            action("Post Application")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Valider le lettrage';
                Image = PostApplication;
                ShortCutKey = 'F9';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()

                begin

                    //GL2024
                    Lettrage.Validate(Rec);
                    //GL2024
                end;
            }
            action("Unapply Entries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Délettrer les écritures';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Clear(GLEntry);
                    GLEntry.SetRange("G/L Account No.", Rec."G/L Account No.");
                    GLEntry.SetRange(Letter, Rec.Letter);
                    if GLEntry.Find('-') then
                        repeat
                            GLEntry.Letter := '';
                            GLEntry."Letter Date" := 0D;
                            GLEntry.Modify();
                        until GLEntry.Next() = 0;
                    if Rec.Letter <> '' then
                        Message('%1', Text001);
                end;
            }

        }

    }

    trigger OnOpenPage()
    var
        DeprecationNotification: Notification;
    begin
        DeprecationNotification.Message(DeprecationNotificationMsg);
        DeprecationNotification.Scope := NotificationScope::LocalScope;
        DeprecationNotification.Send();
    end;

    trigger OnAfterGetRecord()
    begin
        CalcAmount();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AfterGetCurrentRecord();
    end;

    var
        GLAcc: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        //GL2024    GLEntriesApplication: Codeunit "G/L Entry Application";
        Lettrage: Codeunit "Lettrage";
        //GL2024
        ApplnCode: Code[10];
        Debit: Decimal;
        Credit: Decimal;
        Text001: Label 'Lettrage réussi';
        DeprecationNotificationMsg: Label 'This page will be removed in release 25.0 of business central, please use the new Review Entries features which can be found on the General Ledger Entries page to review entries.';
        gApply: Decimal;
        gApplyCode: Code[20];

    procedure CalcAmount()
    var
        GLE: Record "G/L Entry";
    begin
        ApplnCode := Rec.Letter;
        Debit := 0;
        Credit := 0;

        //+REF+FR_APPLYLEDGER
        gApplyCode := rec."Applies-to ID";
        gApply := 0;
        //+REF+FR_APPLYLEDGER//

        if Rec.Letter <> '' then begin
            GLE.SETCURRENTKEY("G/L Account No.", "Posting Date");
            GLE.SetRange("G/L Account No.", Rec."G/L Account No.");
            GLE.SetRange(Letter, Rec.Letter);
            if GLE.Find('-') then
                repeat
                    Debit := Debit + GLE."Debit Amount";
                    Credit := Credit + GLE."Credit Amount";
                until GLE.Next() = 0;
        end else begin
            Debit := Rec."Debit Amount";
            Credit := Rec."Credit Amount";
            //+REF+FR_APPLYLEDGER
            IF rec."Applies-to ID" <> '' THEN BEGIN
                GLE.SETCURRENTKEY("G/L Account No.", "Posting Date");
                GLE.SETRANGE("G/L Account No.", rec."G/L Account No.");
                GLE.SETRANGE("Applies-to ID", rec."Applies-to ID");
                IF GLE.FIND('-') THEN
                    REPEAT
                        gApply += GLE.Amount;
                    UNTIL GLE.NEXT = 0;
            END;
            //+REF+FR_APPLYLEDGER//
        end;
    end;

    local procedure GetCaption(): Text[250]
    begin
        if GLAcc."No." <> Rec."G/L Account No." then
            if not GLAcc.Get(Rec."G/L Account No.") then
                if Rec.GetFilter("G/L Account No.") <> '' then
                    if GLAcc.Get(Rec.GetRangeMin("G/L Account No.")) then;
        exit(StrSubstNo('%1 %2', GLAcc."No.", GLAcc.Name))
    end;

    local procedure AfterGetCurrentRecord()
    begin
        xRec := Rec;
        CalcAmount();
    end;

    local procedure SetAppliesToIDField(OnlyNotApplied: Boolean)
    begin
        Clear(GLEntry);
        GLEntry.Copy(Rec);
        CurrPage.SetSelectionFilter(GLEntry);
        //GL2024
        Lettrage.SetAppliesToID(GLEntry, OnlyNotApplied);
        //GL2024
    end;


}

