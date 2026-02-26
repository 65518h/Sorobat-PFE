page 52049046 "Liste Hist contrat de travail"
{//GL2024  ID dans Nav 2009 : "39001574"
    Editable = false;
    PageType = ListPart;
    SourceTable = "Historique contrat de travail";

    Caption = 'Liste Hist contrat de travail';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1102752000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("No. of Contracts"; Rec."No. of Contracts")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = Basic;
                }
                field(Sex; Rec.Sex)
                {
                    ApplicationArea = Basic;
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = Basic;
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = Basic;
                }
                field("Family Situation A"; Rec."Family Situation A")
                {
                    ApplicationArea = Basic;
                }
                field("Relation de travail"; Rec."Relation de travail")
                {
                    ApplicationArea = Basic;
                }
                field("Employee's type Contrat"; Rec."Employee's type Contrat")
                {
                    ApplicationArea = Basic;
                }
                field("Spécialité"; Rec.Spécialité)
                {
                    ApplicationArea = Basic;
                }
                field("date debut contrat"; Rec."date debut contrat")
                {
                    ApplicationArea = Basic;
                }
                field("Nationalité"; Rec.Nationalité)
                {
                    ApplicationArea = Basic;
                }
                field("Hors Grille"; Rec."Hors Grille")
                {
                    ApplicationArea = Basic;
                }
                field("Regular payments"; Rec."Regular payments")
                {
                    ApplicationArea = Basic;
                }
                field("Temporary payments"; Rec."Temporary payments")
                {
                    ApplicationArea = Basic;
                }
                field("Adjust indemnity amount"; Rec."Adjust indemnity amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employee's type"; Rec."Employee's type")
                {
                    ApplicationArea = Basic;
                }
                field("Regimes of work"; Rec."Regimes of work")
                {
                    ApplicationArea = Basic;
                }
                field("Salary grid"; Rec."Salary grid")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("Take in account deductions"; Rec."Take in account deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Calculation mode of the taxes"; Rec."Calculation mode of the taxes")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive ratio"; Rec."Inclusive ratio")
                {
                    ApplicationArea = Basic;
                }
                field("Default Employment Contract"; Rec."Default Employment Contract")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field(Echelle; Rec.Echelle)
                {
                    ApplicationArea = Basic;
                }
                field(Classe; Rec.Classe)
                {
                    ApplicationArea = Basic;
                }
                field("Type Calendar"; Rec."Type Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Code Calendar"; Rec."Code Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Appliquer Heure Supp"; Rec."Appliquer Heure Supp")
                {
                    ApplicationArea = Basic;
                }
                field("Type Assiduité"; Rec."Type Assiduité")
                {
                    ApplicationArea = Basic;
                }
                field("Slice of imposition"; Rec."Slice of imposition")
                {
                    ApplicationArea = Basic;
                }
                field(Note; Rec.Note)
                {
                    ApplicationArea = Basic;
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Basis salary"; Rec."Basis salary")
                {
                    ApplicationArea = Basic;
                }
                field("National Identity Card No."; Rec."National Identity Card No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Collège"; Rec.Collège)
                {
                    ApplicationArea = Basic;
                }
                field(Echelon; Rec.Echelon)
                {
                    ApplicationArea = Basic;
                }
                field("Entry date Cat/Echelon"; Rec."Entry date Cat/Echelon")
                {
                    ApplicationArea = Basic;
                }
                field("Upgrading date Cat/Echelon"; Rec."Upgrading date Cat/Echelon")
                {
                    ApplicationArea = Basic;
                }
                field("Loaded childs"; Rec."Loaded childs")
                {
                    ApplicationArea = Basic;
                }
                field("Days off -"; Rec."Days off -")
                {
                    ApplicationArea = Basic;
                }
                field("Days off +"; Rec."Days off +")
                {
                    ApplicationArea = Basic;
                }
                field("Days off ="; Rec."Days off =")
                {
                    ApplicationArea = Basic;
                }
                field("Date denier passage Cat/ech"; Rec."Date denier passage Cat/ech")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        recindem: Record "Hist. Default Indemnities";
        FROhistoriqueContratDeTravail: page "Historique contrat de travail";
        "codeContratarchivé": Integer;
        codecontrat: Code[10];


    procedure afficherencour()
    var
        "RECORD": Record "Historique contrat de travail";
    begin
        Record.SetFilter(Code, codecontrat);
        Record.SetFilter("Code contrat archivé", '%1', codeContratarchivé);
        if Record.Find('-') then begin
            FROhistoriqueContratDeTravail.SetTableview(Record);
            FROhistoriqueContratDeTravail.Run
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        codeContratarchivé := Rec."Code contrat archivé";
        codecontrat := Rec.Code
    end;
}

