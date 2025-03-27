package main

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/go-chi/chi/v5"
)

func TestAPIRoutes(t *testing.T) {
	// Create a new router instance
	r := chi.NewRouter()

	// Register routes as in the main function
	r.Get("/api/health", healthCheckHandler)
	r.Get("/api/hello", helloHandler)

	// Test cases
	tests := []struct {
		name           string
		path           string
		expectedStatus int
		expectedBody   string
	}{
		{
			name:           "Health check route",
			path:           "/api/health",
			expectedStatus: http.StatusOK,
			expectedBody:   `{"status": "ok"}`,
		},
		{
			name:           "Hello route",
			path:           "/api/hello",
			expectedStatus: http.StatusOK,
			expectedBody:   `{"message": "Hello from Go API!"}`,
		},
		{
			name:           "Non-existent route",
			path:           "/api/non-existent",
			expectedStatus: http.StatusNotFound,
			expectedBody:   "",
		},
	}

	// Run tests
	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			req, err := http.NewRequest("GET", tc.path, nil)
			if err != nil {
				t.Fatal(err)
			}

			rr := httptest.NewRecorder()
			r.ServeHTTP(rr, req)

			// Check status code
			if status := rr.Code; status != tc.expectedStatus {
				t.Errorf("handler returned wrong status code: got %v want %v",
					status, tc.expectedStatus)
			}

			// Check body if expected
			if tc.expectedBody != "" && rr.Body.String() != tc.expectedBody {
				t.Errorf("handler returned unexpected body: got %v want %v",
					rr.Body.String(), tc.expectedBody)
			}
		})
	}
}
