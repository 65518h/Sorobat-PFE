page 52048888 "Employee Bank Account Card"
{
    //GL2024  ID dans Nav 2009 : "39001409"
    Caption = 'Employee Bank Account Card';
    Editable = true;
    PageType = Card;
    SourceTable = "Employee Bank Account";
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Caption = 'Code';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Addresse';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Adresse (2ème ligne)';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'CP/Ville';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    ShowCaption = false;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code pays';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° téléphone';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic;
                    Caption = 'Contact';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code devise';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code établissement';
                }
                field("Agency Code"; Rec."Agency Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code agence';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° compte bancaire';
                }
                field("RIB Key"; Rec."RIB Key")
                {
                    ApplicationArea = Basic;
                    Caption = 'Clé RIB';
                }
                field("RIB Checked"; Rec."RIB Checked")
                {
                    ApplicationArea = Basic;
                    Caption = 'Vérification RIB';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field(Control24; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° téléphone';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° télécopie';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic;
                    Caption = 'Page d''accueil';
                }
                field(Banque; Rec.Banque)
                {
                    ApplicationArea = Basic;
                    Caption = 'Banque';
                }
            }
        }
    }

    actions
    {
    }

    var
        Mail: Codeunit Mail;
}

