Page 50320 "Liste Gasoil Validé"
{//GL2024 NEW PAGE
    PageType = List;
    Caption = 'Liste Gasoil Validé';
    //GL2024
    SourceTableView = WHERE(Statut = CONST(Valider));
    CardPageId = "Entete Fiche Gasoil Validé";
    SourceTable = "Entete Fiche Gasoil";
    //GL2024
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                Editable = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Journee; rec.Journee)
                {
                    ApplicationArea = all;
                }
                field(Cuve; rec.Cuve)
                {
                    ApplicationArea = all;
                }
                field(Chantier; Rec.Chantier)
                {
                    ApplicationArea = all;
                }
                field("Index Depart"; rec."Index Depart")
                {
                    ApplicationArea = all;
                }
                field("Index Final"; rec."Index Final")
                {
                    ApplicationArea = all;
                }
                field(Utilisateur; rec.Utilisateur)
                {
                    ApplicationArea = all;
                }
                field("Article Gasoil"; rec."Article Gasoil")
                {
                    ApplicationArea = all;
                }
                field(Statut; rec.Statut)
                {
                    ApplicationArea = all;
                }
                field("N° Fiche"; rec."N° Fiche")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        RecUserSetup: Record "User Setup";
        RecLoc: Record Location;
        Filter: Text;
    begin
        RecUserSetup.Get(UserId);
        Rec.FilterGroup(0);
        if not RecUserSetup."Autoriser Filtre Gasoil" then
            Rec.SetRange(Utilisateur, UserId);
        Rec.FilterGroup(2);
        if RecUserSetup.Get(UserId) then begin
            //HS
            Rec.FilterGroup(2);
            if RecUserSetup.Cuve <> '' then
                Rec.SetRange(cuve, RecUserSetup.Cuve)
            else begin
                if RecUserSetup.Affaire <> '' then begin
                    RecLoc.Reset();
                    RecLoc.SetRange(Affaire, RecUserSetup.Affaire);
                    if RecLoc.FindSet() then begin
                        repeat
                            Filter += RecLoc.Code + '|';
                        until RecLoc.Next() = 0;
                    end;
                    if Filter <> '' then
                        Rec.SetFilter(cuve, CopyStr(Filter, 1, StrLen(Filter) - 1));
                end;
                //HS
            end;
            Rec.FilterGroup(0);
        end;
    end;




}

