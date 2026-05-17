page 50156 "Chef Chantier Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Chef Chantier";
    Caption = 'Fiche Chef de Chantier';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Général';

                field("Nom et Prenom"; Rec."Nom et Prenom") { ApplicationArea = All; }
                field("Adresse Email"; Rec."Adresse Email") { ApplicationArea = All; }
                field("Num Projet"; Rec."Num Projet") { ApplicationArea = All; }
                field(Actif; Rec.Actif) { ApplicationArea = All; }
                field("Id Approbateur"; Rec."Id Approbateur") { ApplicationArea = All; }
            }
        }
    }
}