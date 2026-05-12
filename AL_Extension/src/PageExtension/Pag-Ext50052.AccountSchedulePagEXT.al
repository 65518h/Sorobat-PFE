PageExtension 50052 "Account Schedule_PagEXT" extends "Account Schedule"
{
    layout
    {
        addafter(Description)
        {
            field(Note; rec.Note)
            {
                ApplicationArea = all;
            }
        }
        addafter("Totaling Type")
        {
            field("Filtre département"; rec."Filtre département")
            {
                ApplicationArea = all;
            }
            field("Type Flux"; rec."Type Flux")
            {
                ApplicationArea = all;
            }
            field("Source Type"; rec."Source Type")
            {
                ApplicationArea = all;
            }
            field("Balise N"; rec."Balise N")
            {
                ApplicationArea = all;
            }
            field("Balise N-1"; rec."Balise N-1")
            {
                ApplicationArea = all;
            }
            field("Code Categorie"; rec."Code Categorie")
            {
                ApplicationArea = all;
            }
            field("Code Forme juridique"; rec."Code Forme juridique")
            {
                ApplicationArea = all;
            }
            field("Resultat N"; rec."Resultat N")
            {
                ApplicationArea = all;
            }
            field("Resultat N-1"; rec."Resultat N-1")
            {
                ApplicationArea = all;
            }
            field("Source No."; rec."Source No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Totaling)
        {
            field("Concatener Balise N"; rec."Concatener Balise N")
            {
                ApplicationArea = all;
            }
            field("Concatener Balise N-1"; rec."Concatener Balise N-1")
            {
                ApplicationArea = all;
            }
            field("Ligne Vide"; rec."Ligne Vide")
            {
                ApplicationArea = all;
            }
        }
        addafter("Dimension 4 Totaling")
        {
            field("Totalisation auxil crediteur"; rec."Totalisation auxil crediteur")
            {
                ApplicationArea = all;
            }
            field("Totalisation auxil debiteur"; rec."Totalisation auxil debiteur")
            {
                ApplicationArea = all;
            }
        }
        addafter(Show)
        {
            field("Totalisation débiteur"; rec."Totalisation débiteur")
            {
                ApplicationArea = all;
            }
            field("Totalisation créditeur"; rec."Totalisation créditeur")
            {
                ApplicationArea = all;
            }
        }
    }
}

