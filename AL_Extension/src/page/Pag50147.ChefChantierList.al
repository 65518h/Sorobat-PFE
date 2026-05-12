page 50147 "Chef Chantier List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Chef Chantier";
    Caption = 'Liste des Chefs de Chantier';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Nom et Prenom"; Rec."Nom et Prenom") { ApplicationArea = All; }
                field("Adresse Email"; Rec."Adresse Email") { ApplicationArea = All; }
                field("Num Projet"; Rec."Num Projet") { ApplicationArea = All; }
                field(Actif; Rec.Actif) { ApplicationArea = All; }
                field(idApprobateur; Rec."Id Approbateur") { ApplicationArea = All; }

            }
        }
    }
}