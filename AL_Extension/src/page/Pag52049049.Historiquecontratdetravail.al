page 52049049 "Historique contrat de travail"
{//GL2024  ID dans Nav 2009 : "39001577"
    Editable = false;
    PageType = Card;
    SourceTable = "Historique contrat de travail";
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Historique contrat de travail';
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("Code contrat archivé"; rec."Code contrat archivé")
                {
                    ApplicationArea = all;
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("No. of Contracts"; rec."No. of Contracts")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; rec."Job Title")
                {
                    ApplicationArea = all;
                }
                field("Employment Date"; rec."Employment Date")
                {
                    ApplicationArea = all;
                }
                field("Regular payments"; rec."Regular payments")
                {
                    ApplicationArea = all;
                }
                field("Temporary payments"; rec."Temporary payments")
                {
                    ApplicationArea = all;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Statistics Group Code"; rec."Statistics Group Code")
                {
                    ApplicationArea = all;
                }
                field("Relation de travail"; rec."Relation de travail")
                {
                    ApplicationArea = all;
                }
                field("Regimes of work"; rec."Regimes of work")
                {
                    ApplicationArea = all;
                }
                field("Salary grid"; rec."Salary grid")
                {
                    ApplicationArea = all;
                }
                field("Employee's type"; rec."Employee's type")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("date debut contrat"; rec."date debut contrat")
                {
                    ApplicationArea = all;
                }
                field("Termination Date"; rec."Termination Date")
                {
                    ApplicationArea = all;
                }
                field("Inactive Date"; rec."Inactive Date")
                {
                    ApplicationArea = all;
                }
                field("Cause of Inactivity Code"; rec."Cause of Inactivity Code")
                {
                    ApplicationArea = all;
                }
                field("Grounds for Term. Code"; rec."Grounds for Term. Code")
                {
                    ApplicationArea = all;
                }
                field("Employee's type Contrat"; rec."Employee's type Contrat")
                {
                    ApplicationArea = all;
                }
                field(Spécialité; rec.Spécialité)
                {
                    ApplicationArea = all;
                }
                field("Calculation mode of the taxes"; rec."Calculation mode of the taxes")
                {
                    ApplicationArea = all;
                }
                field("Appliquer Heure Supp"; rec."Appliquer Heure Supp")
                {
                    ApplicationArea = all;
                }
                field(Note; rec.Note)
                {
                    ApplicationArea = all;
                }
            }
            group(Paiement)
            {
                Caption = 'Paiement';
                field("Employee Posting Group"; rec."Employee Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Collège; rec.Collège)
                {
                    ApplicationArea = all;
                }
                field(Echelon; rec.Echelon)
                {
                    ApplicationArea = all;
                }
                field("Entry date Cat/Echelon"; rec."Entry date Cat/Echelon")
                {
                    ApplicationArea = all;
                }
                field("Gross Salary"; rec."Gross Salary")
                {
                    ApplicationArea = all;
                }
                field("Basis salary"; rec."Basis salary")
                {
                    ApplicationArea = all;
                }
                field("Loaded childs"; rec."Loaded childs")
                {
                    ApplicationArea = all;
                }
                field("Hors Grille"; rec."Hors Grille")
                {
                    ApplicationArea = all;
                }
                field(Taxable; rec.Taxable)
                {
                    ApplicationArea = all;
                }
            }
            group(Personel)
            {
                Caption = 'Personel';
                field(Address; rec.Address)
                {
                    ApplicationArea = all;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field(Sex; rec.Sex)
                {
                    ApplicationArea = all;
                }
                field("Social Security No."; rec."Social Security No.")
                {
                    ApplicationArea = all;
                }
                field("Family Situation A"; rec."Family Situation A")
                {
                    ApplicationArea = all;
                }
                field(Nationalité; rec.Nationalité)
                {
                    ApplicationArea = all;
                }
                field("Days off -"; rec."Days off -")
                {
                    ApplicationArea = all;
                }
                field("Days off +"; rec."Days off +")
                {
                    ApplicationArea = all;
                }
                field("Days off ="; rec."Days off =")
                {
                    ApplicationArea = all;
                }
            }
            group("indemnités")
            {
                Caption = 'indemnités';
                part("Hist. Default Indemnities"; "Hist. Default Indemnities")
                {
                    ApplicationArea = all;
                    SubPageLink = "Code contrat archivé" = FIELD("Code contrat archivé"),
                                  "Employment Contract Code" = FIELD(Code);
                }
            }
            group("Cotsations Sociales")
            {
                Caption = 'Cotsations Sociales';
                part("Hist. Cotisation Sociale"; "Hist. Cotisation Sociale")
                {
                    ApplicationArea = all;
                    SubPageLink = "Employment Contract Code" = FIELD(Code),
                                  "Code contrat archivé" = FIELD("Code contrat archivé");
                }
            }
        }
    }

    actions
    {
    }
}

