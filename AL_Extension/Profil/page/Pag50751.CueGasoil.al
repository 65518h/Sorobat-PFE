page 50751 "CueGasoil"
{
    Caption = 'Achats & Gasoils';
    PageType = CardPart;
    SourceTable = "Table cue";

    layout
    {
        area(Content)
        {
            cuegroup("Etat des Commandes Achat")
            {
                // CueGroupLayout = Wide;
                // ShowCaption = false;
                field("Total Commande Achat"; REC."Nbr Commande  ")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Commande  Achat';
                    ToolTip = 'Commande  Achat', Comment = '%';
                    DrillDownPageId = "Purchase Order List";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                }
                field("CMDA Ouvert"; REC."Nbr Commande Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = ' Ouvert';
                    ToolTip = ' Ouvert', Comment = '%';
                    DrillDownPageId = "Purchase Order List";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                }
                field("CMDA Lancé"; REC."Nbr Commande Lance ")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Lance  ';
                    ToolTip = 'Lance ', Comment = '%';
                    DrillDownPageId = "Purchase Order List";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                }
            }
            cuegroup("Etat des Demandes Achat")
            {
                field("DA en Attente"; REC."Nbr DA OUVERT-LANCé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'DA en Attente';
                    ToolTip = 'DA en Attente', Comment = '%';
                    DrillDownPageId = "Purchase Request List";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                }
                field("DA Approuvé"; REC."Nbr DA Approuvé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'DA Approuvé';
                    ToolTip = 'DA Approuvé', Comment = '%';
                    DrillDownPageId = "Purchase Request List Approved";
                    Image = None;
                    StyleExpr = true;
                    style = Standard;
                }
                /* field("DA Commandé"; REC."Nbr DA Commandé")
                     {
                         ApplicationArea = Basic, Suite;
                         caption = 'DA Commandé';
                         ToolTip = 'DA Commandé', Comment = '%';
                         DrillDownPageId = "Purchase Request List";
                         Image = None;
                         StyleExpr = true;
                         style = Subordinate;


                     }*/
            }
            cuegroup("Etat des Fiches Gasoils")
            {
                // CueGroupLayout = Wide;
                // ShowCaption = false;
                field("Nbr Fiche Gasoil en cours"; REC."Nbr Fiche Gasoil en cours")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Fiche Gasoil en cours';
                    ToolTip = 'Nbr Fiche Gasoil en cours', Comment = '%';
                    DrillDownPageId = "Entete Gasoil";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                }
                field("Nbr Fiche Gasoil Validé"; REC."Nbr Fiche Gasoil Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Fiche Gasoil Validé';
                    ToolTip = 'Nbr Fiche Gasoil Validé', Comment = '%';
                    DrillDownPageId = "Liste Gasoil Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                }
                // field("Ligne Gasoil Validé"; REC."Nbr Ligne Gasoil Validé")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Ligne Gasoil Validé';
                //     ToolTip = 'Ligne Gasoil Validé', Comment = '%';
                //     DrillDownPageId = "Liste Ligne Fiche Gasoil";
                //     Image = None;
                //     StyleExpr = true;
                //     style = Subordinate;
                // }
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.RESET();
        IF NOT rec.GET THEN BEGIN
            rec.INIT();
            rec.INSERT();
        END;
    end;

    var
        myInt: Integer;
}
