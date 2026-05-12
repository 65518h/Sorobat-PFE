page 50039 "Permission Utilisateur"
{
    PageType = Card;
    SourceTable = User;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("User ID"; rec."User Security ID")
                {
                }
                field(Password; rec."User Name")
                {
                }
                field(Name; rec."Full Name")
                {
                }
                /*  field("Expiration Date"; rec."Expiration Date")
                  {
                  }
                  field("Valideur Devis Comm."; rec."Valideur Devis Comm.")
                  {
                  }
                  field("Change unit price"; rec."Change unit price")
                  {
                  }
                  field("% remise ligne accordee"; rec."% remise ligne accordee")
                  {
                  }
                  field("Change resource unit price"; rec."Change resource unit price")
                  {
                  }
                  field("Autorisation vente marge neg."; rec."Autorisation vente marge neg.")
                  {
                  }
                  field("Location Code"; rec."Location Code")
                  {
                  }
                  field("Service Achat"; rec."Service Achat")
                  {
                  }
                  field("Visa CSA"; rec."Visa CSA")
                  {
                  }
                  field("Reouverture Doc"; rec."Reouverture Doc")
                  {
                  }
                  field("Service Demandeur"; rec."Service Demandeur")
                  {
                  }
                  field("Visa Controle Qualite"; rec."Visa Controle Qualite")
                  {
                  }
                  field(Magasinier; rec.Magasinier)
                  {
                  }*/
            }
        }
    }

    actions
    {
    }
}

