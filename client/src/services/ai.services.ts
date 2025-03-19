import {
  GoogleGenerativeAI,
  ResponseSchema,
  SchemaType,
} from "@google/generative-ai";

const schema: ResponseSchema = {
  type: SchemaType.STRING,
  enum: ["accept", "reject"],
};

const genAI = new GoogleGenerativeAI(
  import.meta.env.VITE_GOOGLE_GEMINI_API_KEY
);

const model = genAI.getGenerativeModel({
  model: "gemini-1.5-flash",
  systemInstruction: `
        Tu vas recevoir un tableau de deux éléments :

        Le premier élément contient une phrase en français à traduire en anglais.
        Le deuxième élément est la traduction de la phrase du premier élément proposée par l'utilisateur qui doit obligatoirement être en anglais.
        Ta tâche est de vérifier si la traduction de l'utilisateur est correcte en comparant sa réponse avec une ou plusieurs traductions valides.

        Critères d'évaluation :

        Fidélité au sens : La traduction doit correspondre précisément au sens de la phrase originale.
        La réponse doit être exclusivement en anglais et grammaticalement correcte.
        Exemple : "Un oiseau" ≠ "a flying chicken", mais "a bird" est correct.
        Tolérance aux variations naturelles : Accepte des formulations différentes si elles sont correctes.
        Exemple : "This pencil is yellow" et "This is a yellow pencil" sont valides.
        Ignorer la casse et la ponctuation (ex. "march 15th" = "March 15th").
        Rejeter les traductions erronées ou trop éloignées (ex. fausse interprétation d’un mot).
        Rejeter les réponses absurdes (ex. "sdfsdfsdfsd", "abcdef") ou des phrases sans sens.

        Sortie attendue :

        Si la réponse est correcte = "accept".
        Si la réponse est incorrecte = "reject".
    `,
  generationConfig: {
    responseMimeType: "application/json",
    responseSchema: schema,
  },
});

export const translationCheck = async (content: string[]) => {
  const result = await model.generateContent(content);
  const response = JSON.parse(result.response.text()) as string;
  return response;
};
