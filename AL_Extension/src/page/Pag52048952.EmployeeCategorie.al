page 52048952 "Employee Categorie"
{//GL2024  ID dans Nav 2009 : "39001473"
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Employee;
    //ABZApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Employee Categorie';
    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("First And Last Name"; rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("ast Name"; rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Catégorie; Rec.Catégorie) { ApplicationArea = all; }
                field(Echelons; Rec.Echelons) { ApplicationArea = all; }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = Basic;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Catégorie soc."; rec."Catégorie soc.")
                {
                    ApplicationArea = Basic;
                }
                field("Basis salary"; rec."Basis salary")
                {
                    ApplicationArea = Basic;
                }
                field("Date Titularisation"; rec."Date Titularisation")
                {
                    ApplicationArea = Basic;
                }
                field("Indemnité imposable"; rec."Indemnité imposable")
                {
                    ApplicationArea = Basic;
                }
                field("Employee's type"; rec."Employee's type")
                {
                    ApplicationArea = Basic;
                }

                field("Entry date Cat/Echelon"; rec."Entry date Cat/Echelon")
                {
                    ApplicationArea = Basic;
                }
                field("Upgrading date Cat/Echelon"; rec."Upgrading date Cat/Echelon")
                {
                    ApplicationArea = Basic;
                }
                field("Familly chief"; rec."Familly chief")
                {
                    ApplicationArea = Basic;
                }
                field("Deduction Loaded child"; rec."Deduction Loaded child")
                {
                    ApplicationArea = Basic;
                }
                field("Loaded childs"; rec."Loaded childs")
                {
                    ApplicationArea = Basic;
                }
                field(Grade; rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field(Echelle; rec.Echelle)
                {
                    ApplicationArea = Basic;
                }
                field("Date Debut Roulement"; rec."Date Debut Roulement")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

