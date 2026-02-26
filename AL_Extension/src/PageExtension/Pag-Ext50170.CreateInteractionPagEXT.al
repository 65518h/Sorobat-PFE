PageExtension 50170 "Create Interaction_PagEXT" extends "Create Interaction"

{

    layout
    {
        modify("Interaction Template Code")
        {
            trigger OnAfterValidate()
            VAR
                lInteractionTemplate: Record "Interaction Template";
            BEGIN

                //+REF+CRM
                lInteractionTemplate.GET(rec."Interaction Template Code");
                rec.Description := lInteractionTemplate.Description;
                //+REF+CRM//

            end;
        }
    }

    actions
    {

    }


}