Page 50301 "Corrige Prix Article / Chantie"
{
    PageType = Card;
    ApplicationArea = all;
    Caption = 'Corrige Prix Article / Chantie';
    layout
    {
        area(content)
        {
            field(Chantier; Chantier)
            {
                ApplicationArea = all;
                Caption = 'Chantier';
                Editable = false;
                TableRelation = Job;
            }
            field(Article; Article)
            {
                ApplicationArea = all;
                Caption = 'Article';
                TableRelation = Item;
            }
            field(Fournisseur; Fournisseur)
            {
                ApplicationArea = all;
                Caption = 'Fournisseur';
                TableRelation = Vendor;
            }
            field(PU; PU)
            {
                ApplicationArea = all;
                Caption = 'PU';
                DecimalPlaces = 3 : 3;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Valider)
            {
                ApplicationArea = all;
                Caption = 'Valider';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if (Chantier = '') or (Article = '') or (Fournisseur = '') or (PU = 0) then Error(Text001);
                    // Location.SetRange(Affectation, Chantier);
                    if Location.FindFirst then
                        repeat
                            ValueEntry.SetCurrentkey("Item No.", "Source No.", "Item Ledger Entry Type", "Location Code");
                            ValueEntry.SetRange("Location Code", Location.Code);
                            ValueEntry.SetRange("Item No.", Article);
                            ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."item ledger entry type"::Purchase);
                            ValueEntry.SetRange("Source No.", Fournisseur);
                            ValueEntry.ModifyAll("Cost per Unit", PU);
                        until Location.Next = 0;
                    Message(Text002);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Chantier := 'mc-133';
    end;

    var
        ValueEntry: Record "Value Entry";
        Location: Record Location;
        Chantier: Code[20];
        Article: Code[20];
        Fournisseur: Code[20];
        PU: Decimal;
        Text001: label 'Remplir Tous Les Champs';
        Text002: label 'Traitement Terminée';
}

