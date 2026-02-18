package placeholder

import (
	"net/http"
	"strconv"

	"github.com/UNIZAR-30226-2026-01/laser_chess_backend/internal/api/apierror"
	"github.com/gin-gonic/gin"
)

type PlaceholderHandler struct {
	service *PlaceholderService
}

func NewHandler(s *PlaceholderService) *PlaceholderHandler {
	return &PlaceholderHandler{service: s}
}

func (h *PlaceholderHandler) GetPlaceholder(c *gin.Context) {
	id, err := strconv.ParseInt(c.Param("id"), 10, 32)
	if err != nil {
		apierror.SendError(c, http.StatusBadRequest, err)
		return
	}

	res, err := h.service.GetByID(c.Request.Context(), int32(id))
	if err != nil {
		apierror.DetectAndSendError(c, err)
		return
	}

	c.JSON(http.StatusOK, res)
}

func (h *PlaceholderHandler) CreatePlaceholder(c *gin.Context) {
	// Struct privado con el json que nos van a pasar
	// Es básicamente un dto que solo se usa aqui
	// Probablemente creemos algunos paquetes con dtos
	var body struct {
		Data string `json:"data" binding:"required"`
	}

	// Mira si el json que nos han pasado coincide con el dto
	if err := c.ShouldBindJSON(&body); err != nil {
		apierror.SendError(c, http.StatusBadRequest, err)
		return
	}

	res, err := h.service.Create(c.Request.Context(), body.Data)
	if err != nil {
		apierror.DetectAndSendError(c, err)
		return
	}

	c.JSON(http.StatusCreated, res)
}
