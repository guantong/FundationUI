
//                  STAR RATINGS                  //
//[SUMAYA]
var one = "<i class=\"fi-star\"></i>";
var two = "<i class=\"fi-star\"></i><i class=\"fi-star\"></i>";
var three = "<i class=\"fi-star\"></i><i class=\"fi-star\"></i><i class=\"fi-star\"></i>";
var four = "<i class=\"fi-star\"></i><i class=\"fi-star\"></i><i class=\"fi-star\"></i><i class=\"fi-star\"></i>";
var five = "<i class=\"fi-star\"></i><i class=\"fi-star\"></i><i class=\"fi-star\"></i><i class=\"fi-star\"></i><i class=\"fi-star\"></i>";
var na = "Unavailable";


//function returns variable of html that needs to be embedded to output the rightful number of stars.
//The function rounds nubmers from 1-5.
function getStars(input) {
    rating = Math.round(input);
    //alert(rating);
    if (rating) {
        switch (rating) {
            case 0:
                return na;
                break;
            case 1:
                return one;
                break;
            case 2:
                return two;
                break;
            case 3:
                return three;
                break;
            case 4:
                return four;
                break;
            case 5:
                return five;
                break;
            default:
                return na;
        }
    }
}

//                  END OF STAR RATINGS                  //