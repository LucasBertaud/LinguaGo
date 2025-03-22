export const loadSvg = async (svgPath: string): Promise<string | null> => {
    try {
      const response = await fetch(svgPath);
      const svgText = await response.text();
      return svgText;
    } catch (error) {
      console.error('Erreur lors de l\'importation de l\'SVG : ', error);
      return null;
    }
  };